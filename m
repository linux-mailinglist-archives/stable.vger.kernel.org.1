Return-Path: <stable+bounces-216757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKqhJbOVk2kd6wEAu9opvQ
	(envelope-from <stable+bounces-216757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 23:09:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB43A147DAA
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD1A301D6A4
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1945289378;
	Mon, 16 Feb 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpNKsgy3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51332820AC;
	Mon, 16 Feb 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771279790; cv=none; b=WUFCQ3yMtwUW9vXD04R5OyBrj4ov/1kn6wGa1pPYqeSwKHxwb5PyHELGmk/jGuTob/XvcmX1Jrgbwz0v81xAj6XLqqikzfXRkg+TVF4RXgIrE84OSwhDeSSun/hGb3mhTEnWtU9TqMdSURn9LT6Ibq/kz2KlYcr77yeTyhdpM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771279790; c=relaxed/simple;
	bh=zOzp8N4OurZfP7u7Ty54SkroNFz43EvcoD2XN1P6v8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVIfxbBqMPH3UTHjZF0j8p3iQiYBzRaqeblivJ0ewGz50vRFa526izDb7dAWP+ikXzn6EwEUy5nm+TEX1/9ySXFSvcPsmwC3CwHfsLOAkowNEMfygZlUXCszZO6++HP13ZzYs5iCcACy5aJUXVO4e70muzecM6swwWlTpkVUuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpNKsgy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5502C116C6;
	Mon, 16 Feb 2026 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771279790;
	bh=zOzp8N4OurZfP7u7Ty54SkroNFz43EvcoD2XN1P6v8k=;
	h=From:To:Cc:Subject:Date:From;
	b=qpNKsgy3KWYdCDG8dyzgHCMB/ON8MYPfSYabGQyPdWqZDwXaN+yyhRQzOgYXHEp+V
	 gSu/Cw7fZhK/URC7W+ZlUPmD0cuAf5OHoNbi24H2Xw/I3WGUsLDCKG/CsN8rfCzsid
	 TQLxEvOTLph0LDuRH9Jt5QFMec2ba/IRYm1FsYLlek1gSg2JQY5MyxIl3a+MSi1whV
	 uHqR4slP18DEW3UZvx73vT8AtqlZfm75iiDTKiUw5UgsCDLqFtJ6ZA9RZ0/tinfOvc
	 j4HIfZU55zR8scGAVxwn6iHZB7M8D9lVUHTWzLmfzAEk8TxIXZhH7nYZS/3PZ7WfDz
	 EdUVKySVv7Ehw==
From: Danilo Krummrich <dakr@kernel.org>
To: lyude@redhat.com,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] nouveau/gsp: fix memory leak in r535_gsp_acpi_dod() unwind paths
Date: Mon, 16 Feb 2026 23:09:42 +0100
Message-ID: <20260216220944.19633-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-216757-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB43A147DAA
X-Rspamd-Action: no action

acpi_evaluate_object() allocates the output buffer when called with
ACPI_ALLOCATE_BUFFER.

Subsequent unwind path do not free the ACPI object however, hence fix
it.

Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
Fixes: a9b9b42b54b2 ("nouveau/gsp: free acpi object after use")
Cc: stable@vger.kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index a575a8dbf727..214ce78b0645 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -863,17 +863,18 @@ r535_gsp_acpi_dod(acpi_handle handle, DOD_METHOD_DATA *dod)
 
 	if (_DOD->type != ACPI_TYPE_PACKAGE ||
 	    _DOD->package.count > ARRAY_SIZE(dod->acpiIdList))
-		return;
+		goto out_free;
 
 	for (int i = 0; i < _DOD->package.count; i++) {
 		if (WARN_ON(_DOD->package.elements[i].type != ACPI_TYPE_INTEGER))
-			return;
+			goto out_free;
 
 		dod->acpiIdList[i] = _DOD->package.elements[i].integer.value;
 		dod->acpiIdListLen += sizeof(dod->acpiIdList[0]);
 	}
 
 	dod->status = 0;
+out_free:
 	kfree(output.pointer);
 }
 #endif

base-commit: 9478c166c46934160135e197b049b5a05753f2ad
-- 
2.53.0


