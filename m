Return-Path: <stable+bounces-38904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACD8A10EE
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624E81F2CBF8
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE01474C6;
	Thu, 11 Apr 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcEApB4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B91474B4;
	Thu, 11 Apr 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831930; cv=none; b=ijt1Ox0pofrc4iET1qZnUbOHbLVlip+rdYpbcqbq6RYj51fi1oVh3eIjwOgjPOodZP8XAX1cImfBZiuTAAqt7EoAcpbDwGER1NaF4IaEkyARnAilIbwl+c41LkhcF2P/sTsAIb0DwB9jYaGXrY1dE9qUn1DzDhVKno99PNDEkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831930; c=relaxed/simple;
	bh=I6ABjbBaFjpWrF29IDj66s7NxWZYvx6MYqYJXshtFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfX0nJ3+CGNyte88q02rl84n/HgN3247SfclhZ26vc6KOaWaOoVUr3vEO6w5ektSYsKzKvHY/0P1Ie2wIWqjPNAW44v0McUL9dJUV+lQ5rEDUtM6uY9gi9vT8Z9veVZm1aZTHQH1X0kqA4qZ+FmWoDJyneF32kciihaR+HhJiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcEApB4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF33EC433F1;
	Thu, 11 Apr 2024 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831930;
	bh=I6ABjbBaFjpWrF29IDj66s7NxWZYvx6MYqYJXshtFxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcEApB4ytX7Q5LloOEnvafibsaIeM6/QERHKy7brJ9l3kdbvj3DlZFLvri7ilpuYj
	 eudhSM1vjYoajWSLEYL+tjbVTCONTeBipMaB23fKyxYuEnGP2UCXQh1INWyF2BR8MU
	 tk8XwaaG2x92NlOHsngHGMdCi5wITzVy445Tnz2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 5.10 173/294] usb: typec: ucsi: Ack unsupported commands
Date: Thu, 11 Apr 2024 11:55:36 +0200
Message-ID: <20240411095440.839552358@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 6b5c85ddeea77d18c4b69e3bda60e9374a20c304 upstream.

If a command completes the OPM must send an ack. This applies
to unsupported commands, too.

Send the required ACK for unsupported commands.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240320073927.1641788-4-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -138,8 +138,12 @@ static int ucsi_exec_command(struct ucsi
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (cci & UCSI_CCI_NOT_SUPPORTED)
+	if (cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge_command(ucsi) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (cci & UCSI_CCI_ERROR) {
 		if (cmd == UCSI_GET_ERROR_STATUS)



