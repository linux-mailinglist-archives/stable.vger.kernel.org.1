Return-Path: <stable+bounces-195072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C723C68321
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CB32B2A420
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43D30F526;
	Tue, 18 Nov 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="Pd9FXlvj"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D430ACEA
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454445; cv=none; b=gJJm4fdJO5abttrCRpgtJ569BpQWwIEMHSbT8glyD6R5numj+yrllY4iK5UtRLXwwINEdUtvDrCqh2kZYekAfMa2HMoMDIKQwG1OQgJFmvfW5WCL8R9QRfa/p6dR3Xxw1fQ/nCFxIN/ycZ6hniY7oAjAyjZYnFSH9IHgRm36vOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454445; c=relaxed/simple;
	bh=3XpadBi7RcjB+sw6CmZ/gXMgSZUBo7YY22/GRGiFNJY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cq2G6B8IY2oA0JsrmQV0H4X/ASq17fx0IzeYmd4KxWMNr/5cKfKIUc0wUaT44kc13l/FAGUgSbQ9Nc8OGBgNXPZ+AZ2utLFJIAk9AnbjfbDA4DpP+OY9olq9NxJ2NDXpqwbLk5c50cok6rzcWR+tOo984QNXaSJ8wqbxS9uWzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=Pd9FXlvj; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 5AI8R73c023767-5AI8R73e023767
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 18 Nov 2025 11:27:07 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 18 Nov
 2025 11:27:07 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 18 Nov 2025 11:27:07 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] scsi: target: reset t_task_cdb pointer in error case
Thread-Topic: [PATCH] scsi: target: reset t_task_cdb pointer in error case
Thread-Index: AQHcWGUg4xOEQbD6pU+6rUudom/Eiw==
Date: Tue, 18 Nov 2025 08:27:07 +0000
Message-ID: <20251118082633.260743-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/17/2025 10:38:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaUEgEHgtFGAkcCwANGygEAQYdEBwNGxwBBg9GBxoPSFhIWkhZWkhZUVpGWV5QRl5YRlxIUEhYSFhIWkhYSFhIWEhaUEgEHgtFGAkcCwANGygEAQYdEBwNGxwBBg9GBxoPSFhIWlpIGxwJCgQNKB4PDRpGAw0aBg0ERgcaD0hY
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=Ga2KAT/PUK66gvzRVKhE/lxJ4rvQrM3uO5+Aoxd9MrY=;
 b=Pd9FXlvje7RWJQ6CXZhVAGtrTD3mb+r8eB1FqZPh7R+J7SVygb/Y9Y01TH4IBHTC3Hjei5PnjIr2
	8xmgA62gCkT8wKDB3u6+cvajnerw7BNsn9TTs7mTVUwvIluKH92ZhZ01PQjcuzkaazKRps98C/6G
	3usLWhBA8eJfovqUfcKOmLlYFbsHtAIZ2RR9esHpN2uOXfCCWZ/GRjxjM/U0LyEeEXxKP8PnfAss
	z45beeHrG4BRKXZHu0oFyPWZa07EdOIJ4yVmZnITuPVhTOuXmufCJmBFjsaUYtJsb0skH5cAZ3IP
	WrGjokBXbx9xqgoaLSRExqsguog7+WunbLwdkg==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

If allocation of cmd->t_task_cdb fails, it remains NULL but is later
dereferenced at the 'err' path.

In case of error reset NULL t_task_cdb value to point at the default
fixed-size buffer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9e95fb805dc0 ("scsi: target: Fix NULL pointer dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/target/target_core_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target=
_core_transport.c
index 0a76bdfe5528..88544c911949 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1524,6 +1524,7 @@ target_cmd_init_cdb(struct se_cmd *cmd, unsigned char=
 *cdb, gfp_t gfp)
 	if (scsi_command_size(cdb) > sizeof(cmd->__t_task_cdb)) {
 		cmd->t_task_cdb =3D kzalloc(scsi_command_size(cdb), gfp);
 		if (!cmd->t_task_cdb) {
+			cmd->t_task_cdb =3D &cmd->__t_task_cdb[0];
 			pr_err("Unable to allocate cmd->t_task_cdb"
 				" %u > sizeof(cmd->__t_task_cdb): %lu ops\n",
 				scsi_command_size(cdb),
--=20
2.43.0

