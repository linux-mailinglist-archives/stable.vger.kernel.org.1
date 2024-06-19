Return-Path: <stable+bounces-53941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE290EBFB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304031F25047
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A314885B;
	Wed, 19 Jun 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zt7NayIq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5E13AA40;
	Wed, 19 Jun 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802125; cv=none; b=cvCUT3/oNgGXqMtElTWgdNt1xxo4TmqKdoKtOcdAak3OUzas9tFtlPpzYq8QAzSZN0fTlssN3AXes9hV9ZnLWAWuy8+G93LWwqexq5PDgQb7LnS9FCNTouMRIcfsLhFNeJ1kZ2dCEQsEFn03/4fa31S85wCTzWF5TKDhYzyB1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802125; c=relaxed/simple;
	bh=qEWuqppaiTHtJwfP9qoULhjvxOwomqfcJgzkrCnvATY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LytRhen+S1QWH6cRhhl9CckDN6JCOglvVPa7n8CcaJPmICuwmzXTEKKmP0WQx6Uc6Wv87RFYR+kzp8PB1FTvi8GgLDQSxgdBlgpmh2PsVGjSqxtZD5EjpNdvNQA8ccONkzDOstY3xRvmtloxxSATh3GHMfWcTdA1FpjMrcuazqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zt7NayIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BACC2BBFC;
	Wed, 19 Jun 2024 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802125;
	bh=qEWuqppaiTHtJwfP9qoULhjvxOwomqfcJgzkrCnvATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt7NayIqBPGMFxAJyQPgMHLNGrd3nDTRhTYh2gb5Zy82aco3ZoVJhExmkKoBoRy95
	 CD8YdqqAFJ4/8ATcP9oIWeOiTeluBH0qMCsjFW9qCBZXPLhRW80YM7CCblfcppjQdR
	 B3WD5RUjdi4l9lQRXIU9E86ngZF5eWsuHY0PzKZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Tso <kyletso@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.6 083/267] usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state
Date: Wed, 19 Jun 2024 14:53:54 +0200
Message-ID: <20240619125609.537068142@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Tso <kyletso@google.com>

commit fc8fb9eea94d8f476e15f3a4a7addeb16b3b99d6 upstream.

Similar to what fixed in Commit a6fe37f428c1 ("usb: typec: tcpm: Skip
hard reset when in error recovery"), the handling of the received Hard
Reset has to be skipped during TOGGLING state.

[ 4086.021288] VBUS off
[ 4086.021295] pending state change SNK_READY -> SNK_UNATTACHED @ 650 ms [rev2 NONE_AMS]
[ 4086.022113] VBUS VSAFE0V
[ 4086.022117] state change SNK_READY -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.022447] VBUS off
[ 4086.022450] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.023060] VBUS VSAFE0V
[ 4086.023064] state change SNK_UNATTACHED -> SNK_UNATTACHED [rev2 NONE_AMS]
[ 4086.023070] disable BIST MODE TESTDATA
[ 4086.023766] disable vbus discharge ret:0
[ 4086.023911] Setting usb_comm capable false
[ 4086.028874] Setting voltage/current limit 0 mV 0 mA
[ 4086.028888] polarity 0
[ 4086.030305] Requesting mux state 0, usb-role 0, orientation 0
[ 4086.033539] Start toggling
[ 4086.038496] state change SNK_UNATTACHED -> TOGGLING [rev2 NONE_AMS]

// This Hard Reset is unexpected
[ 4086.038499] Received hard reset
[ 4086.038501] state change TOGGLING -> HARD_RESET_START [rev2 HARD_RESET]

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240520154858.1072347-1-kyletso@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5415,6 +5415,7 @@ static void _tcpm_pd_hard_reset(struct t
 		port->tcpc->set_bist_data(port->tcpc, false);
 
 	switch (port->state) {
+	case TOGGLING:
 	case ERROR_RECOVERY:
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:



