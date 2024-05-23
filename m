Return-Path: <stable+bounces-45836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C38CD41E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF231C218DE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C714A62D;
	Thu, 23 May 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZR1K1pMP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1B1D545;
	Thu, 23 May 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470501; cv=none; b=GBr0uYWyG2SlQBSZImUN2/KnIVFYkNKux9piWnOHIcCAe/JfNBLE1b3nBqqMMmYnVdk+7hRGzgcJDKP/cneVKCbqLYAbbPomFO0BIPDEyvLp1nKwVTA4EKgPPFe+0lGg8H4d/Uk0HPAdwriqHFVKcUxQcrsnEJURr/qnLx1Y5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470501; c=relaxed/simple;
	bh=i/wEetXsmwLduTHNYRSBlM8afdEbIrkkOPAOT67Sqmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnGwpvmGa0m7gpYvFZFnD2eMrX3YmzdMErQyB4MTdbaKshIzzNKqb1lGmuRffGM1mz+fmR6vs/dadfr5o5wZzA4V5JF3fhZYx1bBOI5OXmEulU7663OHwJ07cHenkIqTGhjaX8RJ1SvzwhjS9nw/qhN0NfBnFLyK6KZ6zveiqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZR1K1pMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB12C2BD10;
	Thu, 23 May 2024 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470500;
	bh=i/wEetXsmwLduTHNYRSBlM8afdEbIrkkOPAOT67Sqmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZR1K1pMPmNL2JjTHl8Bi+3vIBpGjXiRgUOLxx5nBUz9HMfBmQIkMPsuhiRAYUlttP
	 9H7qcuxLGHZdhWwPjX6RdYmNE5jYkeAG8ABWlSGid3VIribhaLESpjC+5mkYWUNLL3
	 4ues7tC7sOABjCGd2IYGHlGRPy3P177Z98txaIUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.8 13/23] usb: typec: ucsi: displayport: Fix potential deadlock
Date: Thu, 23 May 2024 15:13:40 +0200
Message-ID: <20240523130330.252890611@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
References: <20240523130329.745905823@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit b791a67f68121d69108640d4a3e591d210ffe850 upstream.

The function ucsi_displayport_work() does not access the
connector, so it also must not acquire the connector lock.

This fixes a potential deadlock scenario:

ucsi_displayport_work() -> lock(&con->lock)
typec_altmode_vdm()
dp_altmode_vdm()
dp_altmode_work()
typec_altmode_enter()
ucsi_displayport_enter() -> lock(&con->lock)

Reported-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240507134316.161999-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/displayport.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -275,8 +275,6 @@ static void ucsi_displayport_work(struct
 	struct ucsi_dp *dp = container_of(work, struct ucsi_dp, work);
 	int ret;
 
-	mutex_lock(&dp->con->lock);
-
 	ret = typec_altmode_vdm(dp->alt, dp->header,
 				dp->vdo_data, dp->vdo_size);
 	if (ret)
@@ -285,8 +283,6 @@ static void ucsi_displayport_work(struct
 	dp->vdo_data = NULL;
 	dp->vdo_size = 0;
 	dp->header = 0;
-
-	mutex_unlock(&dp->con->lock);
 }
 
 void ucsi_displayport_remove_partner(struct typec_altmode *alt)



