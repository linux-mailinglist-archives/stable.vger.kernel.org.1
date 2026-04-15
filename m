Return-Path: <stable+bounces-238104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD4TG9d232ljTQAAu9opvQ
	(envelope-from <stable+bounces-238104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2F403CC2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 216033051CBD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EF37997E;
	Wed, 15 Apr 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKI6y89"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5F367F3C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252321; cv=none; b=l8vR8IQ5d56udeSyNXPNeiIyIb62LQPKuEAf4wl6sBxb/bn4wwF+9T1+R6/u63hGdUDNNfQQ56+Oh5pNfuDyTAfJSNuwBAvWoMZ4CHRNGq9SYv5QkJFGjJ3T71srYS11M0FXIIdh6RPOvz93C+Pcdb3qvPdtRSWmSmVw6kbi9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252321; c=relaxed/simple;
	bh=VQsTM+mzGxb1tEMnoq0cXierV1ZHH1kctt8ri+qeVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APi6VQpaEn94FRqFEHkXLCMNlJvSR+k3Rt7ZOub/hCVMxwH3BMOTMh68BpcwWKZ9YiKyuG6Db0Ei0rkFnswPp0KqgoKJdLHrv6IjVmeAuwEWxzBbeO6octreysEllgSFwS5HMj86g9onB5/Bl3gt7Opvu/vlxB/l1VZQYhkRkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKI6y89; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50da9a7928cso54574361cf.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252319; x=1776857119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ6fVrO3ohxiKYcaHCxp2wzI9fHSCKIoqnFp5q+kMYA=;
        b=ZdKI6y89qzlqk+Fsg6F2qBDMkDLoq5M2jjacPi4sGcCKblCMHTRdt4+emp0uvuTCae
         MKWEY5iI3TMS48uBDiAdJH8UkKxMJRW29361TJL6BEKrXY9BvrUcPa7NSBhPxvexgWlb
         EmMpTIYoHudPdz4YLkxx1oDIQ0Iyq5BDhAMjEr73RaqD/5apnqRJIrDGlfqstFE3149X
         bapskrxzkZkl9idiA3fg4Oon0lWZ/py6ymFxhZTkwBpZv3/Rls1OcxXpJt443DS7Bg9k
         nama5G8ouKPOCjCLM8ZrklHycDSw1IPxizxc0wrQoYX5ycTmMKxO4rWF/Ah1kHriNViT
         2BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252319; x=1776857119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJ6fVrO3ohxiKYcaHCxp2wzI9fHSCKIoqnFp5q+kMYA=;
        b=OHVOvW+xD8xXaP5sdTtIi2yIuPTu20HHOfcTfO9AnhkTrWZE+PTlQhRx9ds/1Z2FpR
         +TYA/5fR6v1iYSoeR+pSfdxLlnILS5KsQbDqPS+6ND48WzTUmNiy3ME0r/fXimx9OnGf
         /Shuq80vnCkLFsWIQXhOXAsjhqkyJ6sh81ZiArF0fOasKQ/yY1GCeAHrJG7UsnltTqEO
         nosid8fH257IqShrDo/C8X++LbE/K23q6TogDu5lZ9QGirJiNLAJ5ZC0WFLbpVwM6LHd
         m0lad/sK1ybA4PrwvvILnUzGXwt7q1h2GBub6pqz8Mo4/7uUa2PcM9/My0VTKcwxgw5C
         OoMg==
X-Forwarded-Encrypted: i=1; AFNElJ/ewhYOLFrqcCPU21QnVruJ/Q4W2oVnG69HjwoM51n77cMaUVUbs/Py/8bE6hEYmpkxSLtQscY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFjdnVgHxSQWZuPzgOSM49Pgg3VHIjkAFbEOvJGShg6cBJius
	j3wlOOe/0+nXgNPvFxKnEfbd46w2CTYgmiaLgDLAbSzkQQaOeDzu/1QU
X-Gm-Gg: AeBDieuI0b6Fdm6dYbOg1I3FpkuYkhCkKYgTPrBbxe6P6zjvNH7AHEKqmSRiYdCJb+G
	DrOXpAy9+WV16HxhD8lA4x7hJpy0WPAsL9S7ohJ39wmwR8YV+Oig33dt6W+m+AsncTFcixbwU1R
	qVH/Rdr6fn0FpLR7joq9jR+g3W2LAWiIt3618r/Q6709M1uN/oOcnD5bMjMapBs7iprEu9ZoCXB
	Zg/ZmV4Hx2y3sOSKAP9giqYWjWF0Ye5Fjh3YlkJvRM0M8Bhy7zF5sC6H0IipBMxYQMVYrcmaUkA
	OrPzeh/xq/Cn6VdUChxZBq+H9rUhDJcu8HNZN6frT0tDEIg7efzmWL1C1KLxeAckBi5x86kDM18
	PhfVUvcf/AZU+F46OFbjKyVW5BecevTQH1AWgbv+/g725JL/VmCiBFr76dqmNTKC98OnmKf5vYS
	3pxxJVor/8ARDNFohBbAi7gMhPyCWL/XaaKfd0cXaS1IqUgeBqA0e/wJVq29fxUJkGfGbB4Q1ZA
	RAg+/5bNeX/yhGx2GOBRkm6aFhMX8gzqGn2V85tB/CV1AL4zIZKoA==
X-Received: by 2002:ac8:7d11:0:b0:509:35d1:ca37 with SMTP id d75a77b69052e-50dd5aeef70mr330727511cf.16.1776252318729;
        Wed, 15 Apr 2026 04:25:18 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm10621191cf.16.2026.04.15.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] ksmbd: harden ipc_validate_msg() and smb_check_perm_dacl()
Date: Wed, 15 Apr 2026 07:24:59 -0400
Message-ID: <20260415112501.116426-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191533.1467353-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <CAKYAXd9EBFBcy9bJ3=sJiYVYHAYjKYqOqD53UCJ8zWKXF0sAeg@mail.gmail.com> <CAKYAXd8B78Gde_7+Ph0cSL998k4qqs_okB0jky0m5h8i25_AGQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-238104-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B4F2F403CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two ksmbd hardening patches, respun from v1 [PATCH 0/3] per Namjae's
review.

Patch 1 folds v1 1/3 and 2/3 into a single response-side validation
change in ipc_validate_msg().

Patch 2 is v1 3/3 unchanged (minimum ACE size in
smb_check_perm_dacl()).  Please let me know if there's anything
on this 2/2 you want to think through or change.

Changes since v1
----------------

v1 -> v2:

  - 1/3 + 2/3 folded into a single patch (1/2) per Namjae.
  - Dropped the hard KSMBD_IPC_MAX_PAYLOAD (4096) cap on
    RPC_REQUEST and SHARE_CONFIG_REQUEST response paths.  A 4096
    cap would regress NetShareEnumAll and other NDR enumerations
    on servers with many shares -- userspace ksmbd-tools grows
    the response buffer in 4096-byte chunks via g_try_realloc().
    Use check_add_overflow() instead so functional payload size
    is unconstrained but msg_sz cannot wrap unsigned int.
    [Namjae]
  - LOGIN_REQUEST_EXT keeps the [0, NGROUPS_MAX] bound (POSIX
    semantic limit, not an IPC transport cap).  Moved the
    pr_err() into ipc_validate_msg() so the error is reported
    at the IPC boundary. [Namjae]
  - Removed the now-redundant ngroups check and pr_err() from
    ksmbd_alloc_user() in mgmt/user_config.c.  Both call sites
    (ksmbd_login_user and the SPNEGO path in auth.c) reach
    ksmbd_alloc_user() through ksmbd_ipc_login_request_ext(),
    which now rejects negative ngroups at the IPC gate. [Namjae]
  - SPNEGO_AUTHEN_REQUEST left untouched: session_key_len and
    spnego_blob_len are both __u16 so their sum cannot wrap the
    unsigned int msg_sz. [Namjae ack]
  - 2/2 (smb_check_perm_dacl minimum ACE size) unchanged from
    v1 3/3 -- no review yet.

Threading
---------

Sent --in-reply-to v1 [PATCH 0/3] cover
(Message-ID 20260414191533.1467353-1-michael.bommarito@gmail.com)
so v2 lives under the v1 thread.

Michael Bommarito (2):
  ksmbd: validate response sizes in ipc_validate_msg()
  ksmbd: require minimum ACE size in smb_check_perm_dacl()

 fs/smb/server/mgmt/user_config.c |  6 ------
 fs/smb/server/smbacl.c           | 17 +++++++++++++----
 fs/smb/server/transport_ipc.c    | 16 +++++++++++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

--
2.53.0


