Return-Path: <stable+bounces-237958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAp9FBeT3mnZFwAAu9opvQ
	(envelope-from <stable+bounces-237958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12D3FDF85
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A207304604F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC628B7DA;
	Tue, 14 Apr 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scTvEk2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC9283FEF
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194138; cv=none; b=es0Ln9oGZulBjweYus6Yyg3Izyi2AYN2GUs6wshuuG3BGUP44Co29CGEfU+DZ1dXYmPB8lapPEsPEbdwkHf9MH2HGOyvF9f+RxLVbotlUlBZlJ4xIEjZeJV9t331VTwwyCA/rItQuBUQKSK67NtkZZDCOuHSA8Mzxl/jvg4Ze5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194138; c=relaxed/simple;
	bh=OP+X7N1cl7Z1dU4RmWLJlo1ZnQ+9ylvjg9Rirta7jeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+LWSNBYK7SW+8quseKpk3/jq7TdF9NXRaNQRbzmu9tm2E/tkxzMguvk6F5qxd1M+j1EQumOCe19PPHM0xKPj6Uu0FQ5MBfGFYPSKWqloqlYDvMGfCu5i9Mtfsy4xfUHNEe+dH5IOuZTgeFtS2yCDpdX4j7LlhpMnvHtgeRcR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scTvEk2p; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a1e1817db6so51530006d6.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194136; x=1776798936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMAOyE6FGPQM6cNvFV9IHH4uR3bD/7YSN/uFIDfWSw0=;
        b=scTvEk2psCGOW5h0gXFD5MCUvasgzC5B73AkuRoMlZnTwKEMFScUUspwNj+jY26HPy
         wuwCSpDSLj44tKQiHYwV5M0slmZ9nSSpyOpm8Wn/x8xR6+A8HTqhHQNFFn9SUKj6woE1
         D+hWO4SOaZnUtpiXZa0JDw77rd6RXDBe6gjBMC0gGpqzn2blKyyKl4AsTghHP8VTIf19
         SoegTVAm6eKjABnhI8pRsttswReRpLB4tizaRw2ib9XKbt7OOaGUO4iFecxpc9iHLfJ1
         3mpS9+x1eIEwaR2GzrhGIiSYN1ju/GOEvKLbaXBKjUOuOwyh7JT7S9dk0F2b86sbAkeu
         yySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194136; x=1776798936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMAOyE6FGPQM6cNvFV9IHH4uR3bD/7YSN/uFIDfWSw0=;
        b=O4hCYkLV/4QGEy21kJACVgRBrZDLQjyBcdqBLYQEhLtX1pSgL/A/Y+c1k3ScThPkRC
         GSyqQIkJZc2J2TrwKJ/Mslyj13qLAEdw6o6EVHWvq5s8+Khrohou/r1cCxOvPHZIPy/P
         4zmYKGzJbRi34AEhYbrwc8N+JcrYnq2ST9vmJ4jrz4KTb6XnkAFOZ6qzdkzzOkwjue0q
         deFWn0G1GXi15C04qBtvbkYgrVQ5wyBI2b4hdqRmQitRZ2lj/5JWZ0EtY9/hs48tUBya
         bTBIM7+1nzGJzRy8UGopE66l/SdgSZ0JW9BoGfswXPGvqFAnOiCmacU7NpwiXzv84iq1
         cntg==
X-Forwarded-Encrypted: i=1; AFNElJ8n9gMu47qlS0xFmryQDuf2056OGrN+SRHG+xPFVb9eAipDxx2gmrR0TjfOdkQr4LVQmtE0EGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKUPZQinarkHHcU3+Vzcx7wRGJ6Ra/fiuIXn/TvKHZftqhAoB
	xr1ryIVEc3N+nsLocb2UHnXF2+72ccdaX3a8rX2gaaiVtVmZGVl2ueRZxhpmQkvU
X-Gm-Gg: AeBDieue6Kdj9qVuu7Osgscg/Z8Avnc5sAASwIL/theuc3Tww1k6vuDVBl45T3CinbN
	sgv3t+VGVgBXOYehpVre0AQQRYlSuQW6AEqxa4T+GsTOHb+zJEWhKEojiJhwDYMITIXqUbRLjXP
	OeFXsCzNZbLnokKyqpgC9YV2P3D6fmz+iFbh1OxG6Yw+eclUOjBSAGVLJNqbD0kpFp8rf1gdyYO
	T/TIBasOFksA3h+ErYdqpXDY9ufGc3WraSW+o9aBpI5tfG0fJD8ascWgeb42dosaRXctw6hrVmt
	YPWPI1hWTbfU1UBWeloIH+GyzocgRtGuLIOl9dr2aQbuvqvGq/JrVP2boNIUtJYmyxQbuHHQNnq
	9hf/betxh31pRQ/GGWix11k6Hh3PpruC6qyL5VFkLQZqu1Kg5yE/Pdk8RutPXjEn4P7O2jmnXmj
	lTFMyGwfBvV8y5jMPb+hq2giOmhuRzvEJi92cxU9mQmTIQcdHS9N49v9Tsf3dVEKZ32Xe4d5/Nc
	M7QXl8K2pAIECol1C+CG2Y4vzTpcJ/xn+shnwbuVg==
X-Received: by 2002:a05:6214:2024:b0:8a3:7d76:6a6f with SMTP id 6a1803df08f44-8ac8616001dmr308462016d6.5.1776194135984;
        Tue, 14 Apr 2026 12:15:35 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca478a70csm77229126d6.27.2026.04.14.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:15:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/3] ksmbd: harden IPC response arithmetic and ACE walk
Date: Tue, 14 Apr 2026 15:15:30 -0400
Message-ID: <20260414191533.1467353-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237958-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E12D3FDF85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Three ksmbd patches: two hardening fixes for the kernel <-> mountd
IPC arithmetic, plus one authenticated OOB-read fix in the DACL
ACE walker.  All three reproduced under UML + KASAN on v7.0-rc7.
Patch 3 reproduces end-to-end over loopback SMB2 from a guest
client against UML ksmbd + ksmbd.mountd:

  pre-fix:
    BUG: KASAN: slab-out-of-bounds in compare_sids+0x2b1/0x440
     compare_sids
     smb_check_perm_dacl+0x4fe/0x11a0
     smb2_open+0x4eb2/0xad50
     handle_ksmbd_work+0x3d3/0x1140
    "The buggy address is located 4 bytes to the right of
    allocated 32-byte region" with the allocation trace pointing
    at ndr_decode_v4_ntacl() reading the stored xattr.
  post-fix:
    CREATE returns STATUS_ACCESS_DENIED; no KASAN splat; granted
    bits stay at 0 because the tightened bound rejects ace_size=4
    before compare_sids is called.

Patches 1 and 2 reproduced with in-kernel synthetic triggers that
hand ipc_validate_msg() a response with a wrap-matching size:

  patch 1 (RPC_REQUEST payload_sz):
    pre-fix  returns 0 (u32 wrap bypass)
    post-fix returns -EINVAL (payload_sz > KSMBD_IPC_MAX_PAYLOAD)

  patch 1 + 2 (LOGIN_REQUEST_EXT ngroups=-1):
    pre-fix  returns 0 (signed->size_t wrap matches msg_sz)
    post-fix returns -EINVAL (explicit ngroups<0 gate)

Same threat model as the earlier hardening commits aab98e2dbd64
("ksmbd: fix integer overflows on 32 bit systems") and 6f40e50ceb99
("ksmbd: transport_ipc: validate payload size before reading
handle"): the kernel should not trust arithmetic on attacker-
controlled fields even when those fields come from a cooperating
root daemon or an authenticated client writing an xattr.

Patch 1/3 caps the attacker-controlled fields in ipc_validate_msg()
against the existing KSMBD_IPC_MAX_PAYLOAD / NGROUPS_MAX bounds
before they feed the size-computation arithmetic.  Three cases:

  - KSMBD_EVENT_RPC_REQUEST: sizeof(struct) + resp->payload_sz
    (__u32) can wrap in unsigned int; downstream consumer at
    smb2pdu.c:6742 uses rpc_resp->payload_sz for a memcpy.  Cap
    payload_sz against KSMBD_IPC_MAX_PAYLOAD, matching the
    request-side cap in aab98e2dbd64.
  - KSMBD_EVENT_SHARE_CONFIG_REQUEST: sizeof(struct) +
    resp->payload_sz same class; same cap.
  - KSMBD_EVENT_LOGIN_REQUEST_EXT: resp->ngroups is __s32 signed,
    so the existing > NGROUPS_MAX comparison at user_config.c:59
    misses negative values, and the mul sizeof(gid_t) mixes signed
    and size_t in a surprising way.  Reject ngroups outside the
    signed [0, NGROUPS_MAX] range up front.

Patch 2/3 fixes user_config.c so ksmbd_alloc_user() also rejects
negative ngroups explicitly, independent of ipc_validate_msg.

Patch 3/3 tightens bounds checking in smb_check_perm_dacl()'s two
ACE-walk loops.  Today they only require the 4-byte ACE header to
fit in the remaining DACL buffer; an attacker-declared ace->size
of 4 passes both guards, after which the loop reads access_req
(offset 4) and ace->sid (offset 8+) past the real buffer.
parse_sec_desc() already performs an equivalent check; this patch
brings smb_check_perm_dacl() up to the same bar.

Practical exploitation of patches 1-2 is narrow: the wrap-bypass
requires ksmbd.mountd to send a response crafted around the wrapped
size while preserving consistent field values, and the downstream
kvmalloc almost always fails for u32-wrap sizes.  Patch 3 is
reachable post-auth by any client that can SET an ACL and then
OPEN the affected file.

The patch 3 exploit chain is authenticated but otherwise untrusted:
guest session -> TREE_CONNECT -> CREATE evil.dat -> SET_INFO with a
crafted security descriptor (one ACE with size=4) -> close -> re-open
the file, which triggers smb_check_perm_dacl() in smb2_open().  The
malformed SD is accepted by SET_INFO without validation on the write
side; parsing happens on the next open.

Instrumentation, triggers, client, and both console logs are
available on request.

Michael Bommarito (3):
  ksmbd: cap response sizes in ipc_validate_msg()
  ksmbd: reject negative ngroups in ksmbd_alloc_user()
  ksmbd: require minimum ACE size in smb_check_perm_dacl()

 fs/smb/server/mgmt/user_config.c |  2 +-
 fs/smb/server/smbacl.c           | 17 +++++++++++++----
 fs/smb/server/transport_ipc.c    | 42 +++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 12 deletions(-)

--
2.53.0

