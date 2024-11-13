Return-Path: <stable+bounces-92949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767179C7B87
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 19:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C93828969B
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD6205E2E;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqk/y0o9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B722040B8;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523628; cv=none; b=FV9VnDi7heB4qtOgPW28YwNipQHQo3Mwa7PXjcYpHcujS87IfxE8jTusbUVqv9cwzZHAa/jbpbcB52YgAyvHsNngOm9JEMAPglSiAd/m8cpn6dbcguKWHmBXrfvSZ+7yQtxViZRaWLoaJ2n9876EH10G1QHhfk/2Q4n/C/5hr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523628; c=relaxed/simple;
	bh=V2iZdzZI3qg8FtESbW8VZhwjGawTaWAU28cNQL9oiDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g3Vz2GyYo//2Stz9+lOCsjfx5pPMKqC7IGE/rUCwA41dMcmejupdLVhWc7wSx3zgq/4y+FWPON03agWeV1GCP/pnYzENVqmb7n1OZaUfqiktEatdEvP9olqzv5uIlS3QK7j8pmri5KNKEobDSApKZ/OC4iqZBEIyvCkyO9M7HhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqk/y0o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71093C4CEC3;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523627;
	bh=V2iZdzZI3qg8FtESbW8VZhwjGawTaWAU28cNQL9oiDU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pqk/y0o9873eIbAUeC/RUNypRh23pg15z+6KbQsqzRcHAzG8/plVJMjStaazCdmf5
	 FV27RUu90uC5vqH9162dg7/T78L54vUyWs7Mxyhl9P5p69cPSGZGe2+cVwq5dIHhAI
	 aifnG0OybCmXLhVESkCrXOiM3icJLZ4qQUES7G9zW2kwZ0cVhLlkmbEJUVeV0AYpB6
	 LvH3rmExwCG+OzQJJ80btIIf5KDmxjSDcUsSaPp1r/SVXmtJpbCJunsjvrwL5W7mOF
	 92xrO7dMNeQhMofJRNhJAAYzIJ5tG7m+izz9w3JmvuP5MvFZb81N3i6sOyr+9+kGNs
	 oDpvxmtxChVVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F51D637A9;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Date: Wed, 13 Nov 2024 18:46:39 +0000
Message-Id: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/0NGcC/32OwQ6CMBBEf4Xs2TVtUYye/A/DoXS3sIkF0jZEQ
 /h3Cx/gcSbzZmaFxFE4waNaIfIiSaaxCHOqwA127BmFigajzEVr1WB2Mwa6IontcY48o/GKnK9
 vmu4KCldML5+j8wUjZ2iL2dnE2EU7umGvCzZljnt6kJSn+D0OLPpg/mwtGhVSY4g7XxMxPftg5
 X12U4B227YfyfyWm9AAAAA=
X-Change-ID: 20241106-tcp-md5-diag-prep-2f0dcf371d90
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731523626; l=4698;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=V2iZdzZI3qg8FtESbW8VZhwjGawTaWAU28cNQL9oiDU=;
 b=NOMrHtXxF539SZwyOQQ5BbCpnscfkQgiuved+JoyjQ9HdNf9r2y3fZsBbFYKiee0S8J1OtO++
 W7/rrXfdMvjDIiBK9PH8If2RRpLqrO9Oexo/6sAliiefpUTR92lR51f
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Changes in v2:
- Fixup for uninitilized md5sig_count stack variable
  (Oops! Kudos to kernel test robot <lkp@intel.com>)
- Correct space damage, add a missing Fixes tag &
  reformat tcp_ulp_ops_size() (Kuniyuki Iwashima)
- Take out patch for maximum attribute length, see (4) below.
  Going to send it later with the next TCP-AO-diag part
  (Kuniyuki Iwashima)
- Link to v1: https://lore.kernel.org/r/20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com

My original intent was to replace the last non-upstream Arista's TCP-AO
piece. That is per-netns procfs seqfile which lists AO keys. In my view
an acceptable upstream alternative would be TCP-AO-diag uAPI.

So, I started by looking and reviewing TCP-MD5-diag code. And straight
away I saw a bunch of issues:

1. Similarly to TCP_MD5SIG_EXT, which doesn't check tcpm_flags for
   unknown flags and so being non-extendable setsockopt(), the same
   way tcp_diag_put_md5sig() dumps md5 keys in an array of
   tcp_diag_md5sig, which makes it ABI non-extendable structure
   as userspace can't tolerate any new members in it.

2. Inet-diag allocates netlink message for sockets in
   inet_diag_dump_one_icsk(), which uses a TCP-diag callback
   .idiag_get_aux_size(), that pre-calculates the needed space for
   TCP-diag related information. But as neither socket lock nor
   rcu_readlock() are held between allocation and the actual TCP
   info filling, the TCP-related space requirement may change before
   reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
   a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
   return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().

3. Inet-diag "do" request* can create skb of any message required size.
   But "dump" request* the skb size, since d35c99ff77ec ("netlink: do
   not enter direct reclaim from netlink_dump()") is limited by
   32 KB. Having in mind that sizeof(struct tcp_diag_md5sig) = 100 bytes, 
   dumps for sockets that have more than 327 keys are going to fail
   (not counting other diag infos, which lower this limit futher).
   That is much lower than the number of TCP-MD5 keys that can be
   allocated on a socket with the current default
   optmem_max limit (128Kb).

So, then I went and written selftests for TCP-MD5-diag and besides
confirming that (2) and (3) are not theoretical issues, I also
discovered another issues, that I didn't notice on code inspection:

4. nlattr::nla_len is __u16, which limits the largest netlink attibute
   by 64Kb or by 655 tcp_diag_md5sig keys in the diag array. What
   happens de-facto is that the netlink attribute gets u16 overflow,
   breaking the userspace parsing - RTA_NEXT(), that should point
   to the next attribute, points into the middle of md5 keys array.

In this patch set issues (2) and (4) are addressed.
(2) by not returning EMSGSIZE when the dump raced with modifying
TCP-MD5 keys on a socket, but mark the dump inconsistent by setting
NLM_F_DUMP_INTR nlmsg flag. Which changes uAPI in situations where
previously kernel did WARN() and errored the dump.
(4) by artificially limiting the maximum attribute size by U16_MAX - 1.

In order to remove the new limit from (4) solution, my plan is to
convert the dump of TCP-MD5 keys from an array to
NL_ATTR_TYPE_NESTED_ARRAY (or alike), which should also address (1).
And for (3), it's needed to teach tcp-diag how-to remember not only
socket on which previous recvmsg() stopped, but potentially TCP-MD5
key as well.

I plan in the next part of patch set address (3), (1) and the new limit
for (4), together with adding new TCP-AO-diag.

* Terminology from Documentation/userspace-api/netlink/intro.rst

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Dmitry Safonov (5):
      net/diag: Do not race on dumping MD5 keys with adding new MD5 keys
      net/diag: Warn only once on EMSGSIZE
      net/diag: Pre-allocate optional info only if requested
      net/diag: Always pre-allocate tcp_ulp info
      net/netlink: Correct the comment on netlink message max cap

 include/linux/inet_diag.h |  3 +-
 include/net/tcp.h         |  1 -
 net/ipv4/inet_diag.c      | 89 ++++++++++++++++++++++++++++++++++++++---------
 net/ipv4/tcp_diag.c       | 68 ++++++++++++++++++------------------
 net/mptcp/diag.c          | 20 -----------
 net/netlink/af_netlink.c  |  4 +--
 net/tls/tls_main.c        | 17 ---------
 7 files changed, 110 insertions(+), 92 deletions(-)
---
base-commit: f1b785f4c7870c42330b35522c2514e39a1e28e7
change-id: 20241106-tcp-md5-diag-prep-2f0dcf371d90

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



