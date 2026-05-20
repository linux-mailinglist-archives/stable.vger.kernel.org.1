Return-Path: <stable+bounces-249737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AlJFGIoDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:20:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABE58729B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 966673029E81
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3EC32571D;
	Wed, 20 May 2026 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZb14AXJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8D30F932
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247198; cv=none; b=il/xdeLOtGgtQYS2HPJ+qcyaW1pMpUADB4y04/A1qISiQ1ZF+gPL89e9OvMDPCib9R7z+p+CTwMl4iYUe6IFHGyq7nQj8Fc8wuUapccXcU8OAxfn5JvJCGdqEJlQ7vBxrIrd3D7eiyY/ybOf+K23ON7md+Blq8K0F4XvBHEDf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247198; c=relaxed/simple;
	bh=17nxfRsu/mmBWYVlL9OzSO4HeHZxjgfU0eC2ctFuVPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPyRSfKixED43vR1CTEY1ZATup9e5mbb7pOUHF2Kwa42qOAQSX/BSB14bmdvhqItG1y/mZsf7NC3Wf8JnfWhUt88XeIQpH8ilbTb6VOzt0HEJBftQGAlplKMgkFhnQUYkTbmQel5Gh5N0HF/HV7MWt+VdJ/i6/6cXeMpyasRdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZb14AXJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d75bfb259so27312191cf.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247195; x=1779851995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExOjUKx730L5h/Y9Isojqzag32vFvnt6fAHuWyYmv/Q=;
        b=DZb14AXJqszT86bDu9VMgV8k7nfVfjE+J6OGk+Qr2YXZ7udsz0esLIeozpLOPTZy/K
         3+/aNFrrglILIKu3FRO+GDoTPBgd9uTq/dFV9xvgmZG4bKLXm5V8G4IEuW2OyDo/cPfR
         6clJOzDK58LPl8RBYcaHIPFcUU/ch8FZ9vGQr/8Z0Cj8riJ5HQdkxU365sWmhNQGLqzn
         O3NT///o25Pm97FU4mEFca5gbBhaXMg7W9v7ypMMpAxVYguJKdcrwn6OtMnEK2ofyBs2
         hMjs5h5Cr0dmuF5g2OUs+L54VDAqimGr1IPUdavST6sQ5vKzzKgos5Bxo1YUBu10XFBl
         YK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247195; x=1779851995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExOjUKx730L5h/Y9Isojqzag32vFvnt6fAHuWyYmv/Q=;
        b=aHjet73TtUp0SypDTrZsGzBqIZINuihYY91JK44gja6BL1Tj0wm2KuLXiNFRQHI+CQ
         YVimmq5u8tBKxfZkt4GWN9s6novtdtVjEsQMuGMsb6XELjNUv+FKTNF7GWzSm8Q09j4q
         ntBzXfRK9HsJ19C9QzPxyxByGrXhyKhw4IsxzTPFC55/B8lZTO8oWZbKlpppvdh8MF6T
         3xVEWjvz7aTwxSxUa4EpxWcAbT+t2SF89e7o5wtLuSbp0A+16EAREzkz5fVITq4W8umW
         ToFGchcwEt78O2usSAHh+YS8kr4JkAS46xsXuEZajY0Wlo2AgeryZ657RPgiyPCd1vsV
         kuTA==
X-Forwarded-Encrypted: i=1; AFNElJ843jSpFKdKxdHn4IK/gYCeWQx3XF6Hjy35mGn1JMeUyDbg7NrFwpWdSmXqJJCMVnkuENmYOck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKSds5u3veTEjzRlzmEgqQllEn8oP242IT11/CfoUUXNsaUpB
	rJhSXik5YSQri/hA/Uj/npnwsp/mryYRu7qG6A9UMWSSpf5vkWEtGMDn
X-Gm-Gg: Acq92OFfKLzkbI/qOWy/9mN5e3tWb6JsVaSfMOcD3pII/BY7gZilsKifdeGF4yNoJ62
	filu6tAzj5iv/MWODQfeX4cGwH0gr4PhRgk0iOolQLyTwjF+yMVAfFszlEW4ruumIYAmH5O9tiQ
	9hE3IxYos7ryZGT0Cxqj7+5kXuq7edO7yOOX7lBVTGs5w7XtyxpMiPJeZRnRzF5Cwvp+Kqn9CpZ
	8q7g9kTn6wIGB7YG/Jo5Z3h4FOexn3WhF0cfIayEyuiT8ZBZB7rOgMiN+FhoHpPwbBdkt+YXJBf
	Cif90R7r7xkdXzYRpVa5IKRHNuB8joF350coFZUv43jF5dfDTTN/6evOnw6Blh2SZgth1nVPLHk
	7qVfUG2UEBKcca6AyhYGjIWVffFHePq4egZv8/O9aNHOA+roA1zCjaZYsungOTTcc88DTlt1Xoe
	V/7wuFphC/HUjC0Nuw2tNO4bL0woRAIAk9f2h/OV/kLWdu0Vk3PEQyWDtf8JdmZ4CshpNSa3OPv
	zuTedb5Nnq2nDVAEpD0
X-Received: by 2002:a05:622a:8584:b0:50d:a8f5:1bf8 with SMTP id d75a77b69052e-5165a1dc9f7mr251865621cf.37.1779247195399;
        Tue, 19 May 2026 20:19:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm189710571cf.10.2026.05.19.20.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:19:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Marios Makassikis <mmakassikis@freebox.fr>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: reject unsigned non-exempt requests when session requires signing
Date: Tue, 19 May 2026 23:19:23 -0400
Message-ID: <20260520031923.3679744-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,gmail.com,redhat.com,freebox.fr,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249737-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAABE58729B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is the ksmbd SMB2 sibling of Samba CVE-2023-3347 ("SMB2
packet signing not enforced"): when the server-side policy requires
SMB2 signing, unsigned non-exempt requests must be rejected instead
of processed. CVE-2016-2114 is the older Samba SMB1 analogue for
mandatory server signing not being enforced.

When a ksmbd target is configured with "server signing = mandatory"
and a client completes a signed SESSION_SETUP, an attacker on the
network path of that connection can read the cleartext SessionId
from the SMB2 header and inject unsigned TREE_CONNECT, CREATE, and
WRITE requests on the victim's TCP flow. ksmbd processes the
unsigned PDUs and commits attacker-supplied content to the share
under the victim session's authority, without the attacker holding
the victim's credentials.

In fs/smb/server/server.c, __process_request() verifies signatures
only when conn->ops->is_sign_req() returns true. The predicate
(smb2_is_sign_req() at fs/smb/server/smb2pdu.c:8936-8947) reads
only the client-set SMB2_FLAGS_SIGNED and never work->sess->sign --
the per-session "signing required" state set during SESSION_SETUP
at smb2pdu.c:1546 and :1645. MS-SMB2 3.3.5.2.4 requires the server
to reject any unsigned non-exempt request when
Session.SigningRequired is TRUE.

Reject directly in __process_request() when work->sess->sign is
set and the inbound non-exempt request lacks SMB2_FLAGS_SIGNED,
bypassing check_sign_req() to avoid emitting
pr_err("bad smb2 signature") at KERN_ERR for each unsigned PDU.
The set of commands exempt from signing (NEGOTIATE, SESSION_SETUP,
OPLOCK_BREAK) is unchanged.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

Reproduction
============

Tree: linux-mainline 2f448dd9ef4e, x86_64 QEMU+KVM,
CONFIG_SMB_SERVER=y, CONFIG_KASAN=y. Target ksmbd.conf has
"server signing = mandatory", "map to guest = Never",
"valid users = alice"; SMB user alice was added via
ksmbd.adduser.

Conditions: ksmbd configured with "server signing = mandatory"
or a client requesting SMB2_NEGOTIATE_SIGNING_REQUIRED, so
work->sess->sign is set to TRUE after SESSION_SETUP completes.
Encryption MUST NOT be negotiated on the session (smb2_sess_setup
clears sess->sign to FALSE at smb2pdu.c:1558/:1657 when
smb3_encryption_negotiated() is TRUE). The PoCs force SMB 2.1 to
keep the session in the signing-required state.

Harness: a wire-level Python client establishes a normal NTLMv2
SESSION_SETUP on a fresh TCP connection, then on the same
connection issues TREE_CONNECT, CREATE, and WRITE with
SMB2_FLAGS_SIGNED cleared and the Signature field zeroed. A
companion transparent TCP MITM proxy demonstrates the same
primitive without holding credentials: it observes SessionId from
the cleartext SESSION_SETUP response and injects an unsigned
TREE_CONNECT, CREATE, and WRITE into the victim's TCP flow using
that SessionId; the victim's own SMB session continues normally
and observes the attacker's file appear on the share.

Stock kernel: unsigned TREE_CONNECT returns STATUS_SUCCESS with a
tree_id; CREATE returns STATUS_SUCCESS with a file id; WRITE
returns STATUS_SUCCESS and the attacker payload lands on the
share path. The response header carries SMB2_FLAGS_SIGNED with a
non-zero MAC, confirming work->sess->sign was TRUE on this
session.

Patched kernel: same harness, the dispatcher returns
STATUS_ACCESS_DENIED on the first unsigned TREE_CONNECT and
nothing reaches the share. dmesg shows zero
"bad smb2 signature" entries; the rejection bypasses
check_sign_req() so the existing pr_err path is not exercised.
Regression: a legitimate smbclient session with
--client-protection=sign continues to read and write to the
share with no observable change.

Mitigations: until patched, deployments can leave
"server signing = mandatory" disabled in ksmbd.conf (the bypass
is meaningful only when the session sets work->sess->sign), or
configure clients to negotiate SMB3 encryption (sess->enc=TRUE
clears sess->sign and the session uses TRANSFORM_HEADER
encryption for the data path).

Selftests: grep over tools/testing/selftests/ on the patched tree
returns 0 references to ksmbd or smb2_is_sign_req; there is no
in-tree selftest binary that exercises fs/smb/server/server.c's
dispatch gate. The trigger Python client and the TCP MITM proxy
are available off-list on request.
---
 fs/smb/server/server.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 58ef02c423fce..5755f907f29f4 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -143,6 +143,15 @@ static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
 			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
 			return SERVER_HANDLER_ABORT;
 		}
+	} else if (work->sess && work->sess->sign &&
+		   command != SMB2_NEGOTIATE_HE &&
+		   command != SMB2_SESSION_SETUP_HE &&
+		   command != SMB2_OPLOCK_BREAK_HE) {
+		/* MS-SMB2 3.3.5.2.4: Session.SigningRequired==TRUE,
+		 * reject unsigned non-exempt request.
+		 */
+		conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+		return SERVER_HANDLER_ABORT;
 	}
 
 	ret = cmds->proc(work);
-- 
2.53.0

