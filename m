Return-Path: <stable+bounces-219114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJd7Af1anmlSUwQAu9opvQ
	(envelope-from <stable+bounces-219114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:14:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFE190BE8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2B7D31244A2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675FD22127B;
	Wed, 25 Feb 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1vbqLzL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC71FC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984162; cv=none; b=PNMi+SsktZ8X8YEsAV6HnaRf7RNu1OQA9tvz3AUYs9Jb9zJyBX4V1mAVQH9oZraM4Pujz9SezMmWkxNREkN0tgGojML1U538IzKBWuTMbjFV+Nl4DAHc/Gq+maop7ApE+vV0VCJI5f2NBkQrEd6OzIyb4FjFjkR9RuWKz/nFUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984162; c=relaxed/simple;
	bh=EctrzKK5fr39uEJPXD/ZJLo1TzWq0c8HBfDOaayGukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tedTw7e7IsWZGdpkclGF8ocmMDLZobQ3UKs/vjMSUeOMPW2PLweWHy2I/mt6aJpgKH84evHDEr47Fn31kdKJXOCLauAcEaveZyx8IYKEClLpgpOdSj3sMtZ0PEvYg5bBjmKbnWofDprrBbCx5sKsQBQ2Ir9JxnZlXBI51KJdtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1vbqLzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320CC116D0;
	Wed, 25 Feb 2026 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984161;
	bh=EctrzKK5fr39uEJPXD/ZJLo1TzWq0c8HBfDOaayGukk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1vbqLzLdQwo/eqL469POEP4LxbZguGDn4pr0CRW4Qod0y/5JsplhNxSrANxVW9aY
	 NKffR70ur0f5MqaRLJj3uA9bDzG0jeYgAvKpP/AiH/LF5HH9l/nt/uUZ9oap6SIAoz
	 8e9SWkrlylQCx5yY0vZfEn2uxI0keC+gQkCXw2tu3Dznr11whzwSxTAYBL7slsxKa+
	 bTigsU/RLogireHYC9QMxv5qCVQQAEWGPP1K8y60JW89DV1e+PzuNXxH5i5xdyALNi
	 GnEmnAm5zt5H517p7X0D+o27PtTIOgNNqkIDRdAwgD6JTTcynPkbgypdbqu3D0WfLk
	 HdKr7kzXmuNbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] usb: cdns3: remove redundant if branch
Date: Tue, 24 Feb 2026 20:49:17 -0500
Message-ID: <20260225014919.3767757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022420-straddle-unquote-c2f6@gregkh>
References: <2026022420-straddle-unquote-c2f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219114-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 23EFE190BE8
X-Rspamd-Action: no action

From: Hongyu Xie <xiehongyu1@kylinos.cn>

[ Upstream commit dedab674428f8a99468a4864c067128ba9ea83a6 ]

cdns->role_sw->dev->driver_data gets set in routines showing below,
cdns_init
  sw_desc.driver_data = cdns;
  cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
    dev_set_drvdata(&sw->dev, desc->driver_data);

In cdns_resume,
cdns->role = cdns_role_get(cdns->role_sw); //line redundant
  struct cdns *cdns = usb_role_switch_get_drvdata(sw);
    dev_get_drvdata(&sw->dev)
      return dev->driver_data
return cdns->role;

"line redundant" equals to,
	cdns->role = cdns->role;

So fix this if branch.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20241231013641.23908-1-xiehongyu1@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 87e4b043b98a ("usb: cdns3: fix role switching during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 465e9267b49c1..98980a23e1c22 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -529,9 +529,7 @@ int cdns_resume(struct cdns *cdns)
 	int ret = 0;
 
 	if (cdns_power_is_lost(cdns)) {
-		if (cdns->role_sw) {
-			cdns->role = cdns_role_get(cdns->role_sw);
-		} else {
+		if (!cdns->role_sw) {
 			real_role = cdns_hw_role_state_machine(cdns);
 			if (real_role != cdns->role) {
 				ret = cdns_hw_role_switch(cdns);
-- 
2.51.0


