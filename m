Return-Path: <stable+bounces-237961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFIdInCS3mnZFwAAu9opvQ
	(envelope-from <stable+bounces-237961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F25713FDF11
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B597301A75D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3E29E0E5;
	Tue, 14 Apr 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnBwQcDu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08355231842
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194156; cv=none; b=WR0xEHDW5JBQyo0F9lgdLBw7/GqLo69jHblckB56Q7ntXEpdn51vGv4XRfdU337MrtY1WCF4Lf6Gx1Lb/jM0kTWst1ExiNWcvqpuvev2+n9UBjQiJlvLdII2nXFAhxecFUXVLCVA0mdfJBk4R4ntDABzQ4V3kG2XK4KNfQTSKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194156; c=relaxed/simple;
	bh=JiHyAQnBgby1VcbYNnZZ0ideNFMgo0ThwRgHFgMksCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgSQx+q0VoCLKiSJ502krm1+BjkkV82gCl1mIkDijt5VUhQ8+yoOE0MoWRwxDFuSFsY3bBjQXo5uanxhMAFJfO/Pu3f5G3iHlk0VIrDkrgRw85Gt3dpUxENYQF0+WqrcmxOE0jsctkC0imv449KJQUKJhH8hv9BVBocK0YUyKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnBwQcDu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca2726f61so36114026d6.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194154; x=1776798954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTJ5HC0a2hN/amf4dUG1Nu4xp3YoqCRYI98HEaqXpF0=;
        b=CnBwQcDu36ic+hOBfxBCMmxxGxDZSSY1hVTTR1Jr901hQccQnpDmcIJmVl/0nA5JaS
         +JZk8kq0L4tzW1hIszGuUlOtzF9oyNrZz83JzwkDLhiiGYgkwNHy+uSQcCcqFdJFpMHA
         8NpM58bUjN/m8JnGeualKMajE+SURv3QxlFrTbY4CjIbnqKAWC90PyZca39z2egUQC/l
         XoJIiCuJknlXfZ3g6J+JM9v6Q17W9M2WJipSjbS+woEjhfzYytr51hGuTwkf6bb7HQ/J
         D1vGJDnDuQGiTxpqN5WMvHDSZ/0ACv2YwEBArHq5ilB1L5cLtZuUbDv8BezXSlLm71Jy
         V4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194154; x=1776798954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTJ5HC0a2hN/amf4dUG1Nu4xp3YoqCRYI98HEaqXpF0=;
        b=GEqVfeoRvpy1SSNn2RAKP12R04S7/tUsTENepie3CTXHSruA4er2tvDHtXqxrQlmoe
         zE9FKwJmb9isf5GLsblBETRSZEEt1x7+KDU3mpqJRQjMRqQUYll8sxrllHgidUBTEuix
         M5V7ohkM8zaIiC1aB8uVT9PGpmaoi1+XxVSpwiNhOatqL7bChuNiUQNlra7SlbRt6xvT
         tJ1z6ssWTu1Vrjn3E+shOFmXMyQluUoFE83+i0TyV5vAZWqaCjAsW2ZtOGjk3Bf1LD6l
         CidFjn4HIFyF2rur86OICcDU21hYSrEU4bM7/RtNP3stN/s1xSXaOtC2R7HMESUpGwIJ
         n5Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+saCxYNCjASCduyC/c2BqD0M69b+39NdOTygJZ/An+UXrtxUW61Pfin3QuL54WM6GkvPCzfRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48imz2ceijXZvZgizpZrI48Bk/8UdVOLO68cozBWeSAqSLiF0
	vCZqvXHux4gzhIQAygU9nPtGwZLGtUuhgMfBuXHQCTdMavK2m9Vzlap4
X-Gm-Gg: AeBDieuBd3wWjvlL2FI81ZEKrnSX53g3UzqiBGI10G4BnlWzeFsYho83vic9YY+59QO
	2yOrBXO/cA1O5erR1voFBuhtnsqliKsYwUHugzQ7ZyuJIHTGaEtWMDgppNIwUYUOLmbzpdVxXKC
	1Di9rOMBfUITMYtXx3PwE9cOpMoxyeplyGdQbTf2zqCSH6DOMn8aUrFgQgaCSS368WXeluPaT2o
	H0D/g6FvYbOCOlCC57CQhNnQZCFYlsYBey+4CcKFM0vgr4o9UDRI420xzujhmJLTDYM8YZA4tLY
	l32MBQpU526WPN55YHEedH6txNiiq3JWhXbfGm59fC4Xk/249WqdkBcZXg3aKg/OfEB02mnHFJo
	rsynkCRRhLLptn36f19JPZaof7bzHGVmteUArJBRNHoc6X6uM20QbPysUl4wqdePO+uFy7OCKuK
	YoNVOYPvhQRYdGVgYdx83KryeBgopJqYqkY52keJYIRDl/rCTBaKvqwyBmhkDVwP3O8T5/FyVpn
	4TAYjWwrUT/9KEAnKakdV7SHZbjO9Y=
X-Received: by 2002:a05:6214:e42:b0:8ac:abc5:8762 with SMTP id 6a1803df08f44-8acabc58abcmr147012646d6.31.1776194137524;
        Tue, 14 Apr 2026 12:15:37 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca478a70csm77229126d6.27.2026.04.14.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:15:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ksmbd: cap response sizes in ipc_validate_msg()
Date: Tue, 14 Apr 2026 15:15:31 -0400
Message-ID: <20260414191533.1467353-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191533.1467353-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237961-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F25713FDF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipc_validate_msg() computes the expected message size for each
response type by adding (or multiplying) attacker-controlled fields
from the daemon response to a fixed struct size in unsigned int
arithmetic.  Three cases can overflow:

  KSMBD_EVENT_RPC_REQUEST:
      msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
  KSMBD_EVENT_SHARE_CONFIG_REQUEST:
      msg_sz = sizeof(struct ksmbd_share_config_response) +
               resp->payload_sz;
  KSMBD_EVENT_LOGIN_REQUEST_EXT:
      msg_sz = sizeof(struct ksmbd_login_response_ext) +
               resp->ngroups * sizeof(gid_t);

resp->payload_sz is __u32 and resp->ngroups is __s32.  Each addition
can wrap in unsigned int; the multiplication by sizeof(gid_t) mixes
signed and size_t, so a negative ngroups is converted to SIZE_MAX
before the multiply.  A wrapped value of msg_sz that happens to
equal entry->msg_sz bypasses the size check on the next line, and
downstream consumers (smb2pdu.c:6742 memcpy using rpc_resp->payload_sz,
kmemdup in ksmbd_alloc_user using resp_ext->ngroups) then trust the
unverified length.

This is the response-side analogue of aab98e2dbd64 ("ksmbd: fix
integer overflows on 32 bit systems"), which hardened the request
side by bounding attacker-controlled lengths against the existing
KSMBD_IPC_MAX_PAYLOAD / NGROUPS_MAX caps.  Apply the same caps on
the response side: reject resp->payload_sz > KSMBD_IPC_MAX_PAYLOAD
for RPC_REQUEST and SHARE_CONFIG_REQUEST, and reject resp->ngroups
outside the signed [0, NGROUPS_MAX] range for LOGIN_REQUEST_EXT.
With those caps the subsequent additions and multiplication are
bounded well below UINT_MAX.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/server/transport_ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -497,6 +497,8 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_rpc_command *resp = entry->response;

+		if (resp->payload_sz > KSMBD_IPC_MAX_PAYLOAD)
+			return -EINVAL;
 		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
 		break;
 	}
@@ -513,7 +515,8 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		struct ksmbd_share_config_response *resp = entry->response;

 		if (resp->payload_sz) {
-			if (resp->payload_sz < resp->veto_list_sz)
+			if (resp->payload_sz < resp->veto_list_sz ||
+			    resp->payload_sz > KSMBD_IPC_MAX_PAYLOAD)
 				return -EINVAL;

 			msg_sz = sizeof(struct ksmbd_share_config_response) +
@@ -526,6 +529,8 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		struct ksmbd_login_response_ext *resp = entry->response;

 		if (resp->ngroups) {
+			if (resp->ngroups < 0 || resp->ngroups > NGROUPS_MAX)
+				return -EINVAL;
 			msg_sz = sizeof(struct ksmbd_login_response_ext) +
 					resp->ngroups * sizeof(gid_t);
 		}
--
2.53.0

