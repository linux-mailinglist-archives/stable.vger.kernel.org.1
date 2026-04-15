Return-Path: <stable+bounces-238105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L3nI69132lWTQAAu9opvQ
	(envelope-from <stable+bounces-238105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780B403BD6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10F963061D5A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8437AA72;
	Wed, 15 Apr 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmfFjiR7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF33264E2
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252322; cv=none; b=OXI1NCG9E82gSnFw4IFEDzKOssKm6N/f8P/O7VyTj0+A47YUfOHWqkJDPzuglITAcOFwTvcvL2T8iYP4zrggUVYBXPNAQE0yla+4GtyIZViXDoqM+RaRx5rISJhFp9o1+fjaxa0a4wnmjagupsaYyYfKojrKcx0Yz3OS8KHMenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252322; c=relaxed/simple;
	bh=tYeUIH6LHvR6PIC/sVosrXxrgB8XX9duPCDm7zG4+V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNtdAIutp+ACdwOFmaCZAxOVZVuu4YlTow09VaAMfjTVM+mf1+pjW6fDFuQenuNGca1fXUieJi8BtOac9z1foMLuAMufG4jMw8zLDJG6b22w/gOCnillRtPWUz7gBQkAt60Xe9yjSyspc2C+BR0rpyYYnyUfQcgYluKv18WBVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmfFjiR7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d75bfb259so44073441cf.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252320; x=1776857120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0HEvKnsU+8vNgxOY8boDbMT5EKcWTf7YNZVr8Eae3g=;
        b=jmfFjiR7S5WPZGy0zay8UiiiFHribsglpkPjflRUgiYjg/ouZegLovO4l5kFCV/Tul
         YAlu5IQuXaCmWxDXv6f5au41u+KA9/audYXFiGFzSxLCwcylDdm3sDoniNembRptveKb
         WiqUsZKYQhyyTE4B6nSJmqc2AyKoQ2iLWouDNDOKy0dPbta/lyNlvt60/NRq47hLTA6M
         vjoN3hQCu961wPnRiUZRrXkCfzFv86Kjog99j/LWQpsHSXkhGBzvpUnXkGMtB27divHP
         BS5RH8hjUHGVx+/vtcDtotUtD9c+Ndqhu75d+UtyrdVcHZOwVTkILHVlRTuIjTjtM9xE
         5nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252320; x=1776857120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0HEvKnsU+8vNgxOY8boDbMT5EKcWTf7YNZVr8Eae3g=;
        b=TUWg3PkJPaIOKHDZdMTF/K43LMBKuDCDddLWdg++kNSr/DEW0XM9HkI95L0nnF/ybu
         ubagyxnM2kYKLS4gyOM9yxICCOQ3iDy+gqWnj6MeZ1t56hoGumaeWmQFnzneBg61DuQC
         dFeNp53xnCfP1kDGFP8Sz6i73ypY4kuwszj7AhzJrpOoRJoNouUa50ELTHjlk8ahefCq
         Zm84zdzAVlT8UFCm7VlJJMJcIHHfkFAsb57XChdDxNMtBcALIV7KgAYwx5e02KRfm4aP
         yDVQsMPuxWcvQedCwxNxqKe7DahNL5zMghxtFPUtsNXbJsy3qihkUmulVvJI7fbyAZBm
         z68Q==
X-Forwarded-Encrypted: i=1; AFNElJ9bSDoEiFozxnRJ7V4W7Ccn+GHALv7B7Rsg69dJj/MBfYvJ760v6yV8IBQGqnHkIxDc67Ux3mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEnxAckBRez8GHPDFPGjUOjJlHzd/P8+eZ1w+qEpcZcA7US4L
	ajluSJ/eJ1JzZIhpLMNcbt5VCaV1+yKpTVdz7s0wCA49y7niNPfYsN6l
X-Gm-Gg: AeBDietI9+KY2PQVwLTR/dF/IOrqQqu4EtBuiJVR2syAzM3agKax5L66EzftD99WeSI
	qlWTd605kNxHe5VzY6VRio3sZv4HT4BlVFsSnOm4Lj1RZn7hW6dPojBUgO+KbNj7YTFRqaEFu9q
	fJBr9+RHkf9Z/BBLR9WTAT6wnXr1VIH8rb6upi0bYeyeYjRFHCnuaELgdV4tiYA+gFiqshv/Gvp
	ZYeW3DxEyHMMbBBB7o1zh+I45ofL4CylfTYllw2eCQAfxz6XSzHte3kaVFBi5Dk5WBHatXid/pS
	NkrfP30Ol5RWx30BxWiC6q9Yeg92q/7dNZQp+kBS1Sl1+JjZNSfdQLOHbTSeWsvxIO1BGXA834t
	XIka5yZSEvkpkRqYAGdbH0sRJ4NA/KEk6we9MH84zj5i9Cov6W1cY36RXYG3MuOmWoP9FfjupYY
	/jGeRJ2u53Adgv77NazYGbaOSHPk446PPIMFDYqo8K52Wtco/UjPpb/aQQf+KVnY306Z2NVGa/Q
	0JSqE3/jcrg4JQJiqAf55RQXdW707z2dh6Rek4NiLwAECWvYhsle55H4U7ApBVg
X-Received: by 2002:a05:622a:8a0b:b0:50d:8c22:47f2 with SMTP id d75a77b69052e-50dd5bdb454mr250054181cf.44.1776252320060;
        Wed, 15 Apr 2026 04:25:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm10621191cf.16.2026.04.15.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] ksmbd: validate response sizes in ipc_validate_msg()
Date: Wed, 15 Apr 2026 07:25:00 -0400
Message-ID: <20260415112501.116426-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112501.116426-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <CAKYAXd9EBFBcy9bJ3=sJiYVYHAYjKYqOqD53UCJ8zWKXF0sAeg@mail.gmail.com> <CAKYAXd8B78Gde_7+Ph0cSL998k4qqs_okB0jky0m5h8i25_AGQ@mail.gmail.com>
 <20260415112501.116426-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238105-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1780B403BD6
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

Use check_add_overflow() on the RPC_REQUEST and SHARE_CONFIG_REQUEST
paths to detect integer overflow without constraining functional
payload size; userspace ksmbd-tools grows NDR responses in 4096-byte
chunks for calls like NetShareEnumAll, so a hard transport cap is
unworkable on the response side.  For LOGIN_REQUEST_EXT, reject
resp->ngroups outside the signed [0, NGROUPS_MAX] range up front and
report the error from ipc_validate_msg() so it fires at the IPC
boundary; with that bound the subsequent multiplication and addition
stay well below UINT_MAX.  The now-redundant ngroups check and
pr_err in ksmbd_alloc_user() are removed.

This is the response-side analogue of aab98e2dbd64 ("ksmbd: fix
integer overflows on 32 bit systems"), which hardened the request
side.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Fixes: a77e0e02af1c ("ksmbd: add support for supplementary groups")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/server/mgmt/user_config.c |  6 ------
 fs/smb/server/transport_ipc.c    | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
index a3183fe5c536..cf45841d9d1b 100644
--- a/fs/smb/server/mgmt/user_config.c
+++ b/fs/smb/server/mgmt/user_config.c
@@ -56,12 +56,6 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 		goto err_free;
 
 	if (resp_ext) {
-		if (resp_ext->ngroups > NGROUPS_MAX) {
-			pr_err("ngroups(%u) from login response exceeds max groups(%d)\n",
-					resp_ext->ngroups, NGROUPS_MAX);
-			goto err_free;
-		}
-
 		user->sgid = kmemdup(resp_ext->____payload,
 				     resp_ext->ngroups * sizeof(gid_t),
 				     KSMBD_DEFAULT_GFP);
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2dbabe2d8005..1c5645238bd3 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -13,6 +13,7 @@
 #include <net/genetlink.h>
 #include <linux/socket.h>
 #include <linux/workqueue.h>
+#include <linux/overflow.h>
 
 #include "vfs_cache.h"
 #include "transport_ipc.h"
@@ -497,7 +498,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_rpc_command *resp = entry->response;
 
-		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
+		if (check_add_overflow(sizeof(struct ksmbd_rpc_command),
+				       resp->payload_sz, &msg_sz))
+			return -EINVAL;
 		break;
 	}
 	case KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST:
@@ -516,8 +519,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 			if (resp->payload_sz < resp->veto_list_sz)
 				return -EINVAL;
 
-			msg_sz = sizeof(struct ksmbd_share_config_response) +
-					resp->payload_sz;
+			if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
+					       resp->payload_sz, &msg_sz))
+				return -EINVAL;
 		}
 		break;
 	}
@@ -526,6 +530,12 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		struct ksmbd_login_response_ext *resp = entry->response;
 
 		if (resp->ngroups) {
+			if (resp->ngroups < 0 ||
+			    resp->ngroups > NGROUPS_MAX) {
+				pr_err("ngroups(%d) from login response exceeds max groups(%d)\n",
+				       resp->ngroups, NGROUPS_MAX);
+				return -EINVAL;
+			}
 			msg_sz = sizeof(struct ksmbd_login_response_ext) +
 					resp->ngroups * sizeof(gid_t);
 		}
-- 
2.53.0


