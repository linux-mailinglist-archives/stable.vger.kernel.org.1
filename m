Return-Path: <stable+bounces-223764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDm5JjS3r2mKbwIAu9opvQ
	(envelope-from <stable+bounces-223764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:16:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A3245C1B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DE73302B4F4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4C2E285C;
	Tue, 10 Mar 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uOqpuSqW"
X-Original-To: stable@vger.kernel.org
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E29309EF9
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123376; cv=none; b=HmHsEOYJdGse2rs/fsJNjV/Csrye/KygAPSwktfSlFe5eeLGa6NbSxgrcgQMaKUmWsKz58LSHr/yTN/QLrELowrjfow9pfiMh7KNmmgEre3/rvq3jL5eKCz8Q1Una4w2gAukIEFlQTi8CPbbEEI0wrJTsX7mRe3wn0iQ9JTr4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123376; c=relaxed/simple;
	bh=V406/rPXu/YUIisP2G7qY+gz/9cYq0sph96OdoYyzlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmSPCBiacW+Gqcgue0UfhJxqspHSgyKqxgpJyV9m1gq2U9akEf48Bp7n/EOly1sGsDzX7vUqgFuR9XFp9lntJd57YVJ2W8yysEnTjbR/ItpaFjnpFjDygyQeerrPHnyEUDz4hPMhcrFLvvlk9Qhmp6XN+Ag09YSpjSHGtDMQXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uOqpuSqW; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773123372;
	bh=gJOZXId0GFVYAen4FctmUbODBh+w5e6b09y93ORS6hE=;
	h=From:Subject:Date:Message-Id;
	b=uOqpuSqW8y0omnp5MA9h2h7LKpLO/VzxDnpkDxIe7NqZprsOinsAjV0h2rdI9KfXz
	 bN9Gefjap+jatw6Y+kTiaS3dETeesK6VtJaFyXOAKSJr/8gVPW0lwogBgh1OwYZ/0W
	 6S0WeatoIqon75DYFZQeJbViPre5BbdYLP7u0yNY=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.24) with ESMTP
	id 69AFB702000008BC; Tue, 10 Mar 2026 14:15:33 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 47989410748319
X-SMAIL-UIID: 8723722B6C934E3D9F8B2BE32A179915-20260310-141533-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
Date: Tue, 10 Mar 2026 14:15:27 +0800
Message-Id: <20260310061527.1059694-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 616A3245C1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223764-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sina.com:server fail,sto.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[sina.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,sina.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 2fc31465c5373b5ca4edf2e5238558cb62902311 ]

Precision markers need to be propagated whenever we have an ARG_CONST_*
style argument, as the verifier cannot consider imprecise scalars to be
equivalent for the purposes of states_equal check when such arguments
refine the return value (in this case, set mem_size for PTR_TO_MEM). The
resultant mem_size for the R0 is derived from the constant value, and if
the verifier incorrectly prunes states considering them equivalent where
such arguments exist (by seeing that both registers have reg->precise as
false in regsafe), we can end up with invalid programs passing the
verifier which can do access beyond what should have been the correct
mem_size in that explored state.

To show a concrete example of the problem:

0000000000000000 <prog>:
       0:       r2 = *(u32 *)(r1 + 80)
       1:       r1 = *(u32 *)(r1 + 76)
       2:       r3 = r1
       3:       r3 += 4
       4:       if r3 > r2 goto +18 <LBB5_5>
       5:       w2 = 0
       6:       *(u32 *)(r1 + 0) = r2
       7:       r1 = *(u32 *)(r1 + 0)
       8:       r2 = 1
       9:       if w1 == 0 goto +1 <LBB5_3>
      10:       r2 = -1

0000000000000058 <LBB5_3>:
      11:       r1 = 0 ll
      13:       r3 = 0
      14:       call bpf_ringbuf_reserve
      15:       if r0 == 0 goto +7 <LBB5_5>
      16:       r1 = r0
      17:       r1 += 16777215
      18:       w2 = 0
      19:       *(u8 *)(r1 + 0) = r2
      20:       r1 = r0
      21:       r2 = 0
      22:       call bpf_ringbuf_submit

00000000000000b8 <LBB5_5>:
      23:       w0 = 0
      24:       exit

For the first case, the single line execution's exploration will prune
the search at insn 14 for the branch insn 9's second leg as it will be
verified first using r2 = -1 (UINT_MAX), while as w1 at insn 9 will
always be 0 so at runtime we don't get error for being greater than
UINT_MAX/4 from bpf_ringbuf_reserve. The verifier during regsafe just
sees reg->precise as false for both r2 registers in both states, hence
considers them equal for purposes of states_equal.

If we propagated precise markers using the backtracking support, we
would use the precise marking to then ensure that old r2 (UINT_MAX) was
within the new r2 (1) and this would never be true, so the verification
would rightfully fail.

The end result is that the out of bounds access at instruction 19 would
be permitted without this fix.

Note that reg->precise is always set to true when user does not have
CAP_BPF (or when subprog count is greater than 1 (i.e. use of any static
or global functions)), hence this is only a problem when precision marks
need to be explicitly propagated (i.e. privileged users with CAP_BPF).

A simplified test case has been included in the next patch to prevent
future regressions.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20220823185300.406-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ The context change is due to the commit 8ab4cdcf03d0
("bpf: Tidy up verifier check_func_arg()") in v6.0
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48776d23b44e..fd9e891fe48b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5539,6 +5539,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->mem_size = reg->var_off.value;
+		err = mark_chain_precision(env, regno);
+		if (err)
+			return err;
 	} else if (arg_type_is_int_ptr(arg_type)) {
 		int size = int_ptr_type_to_size(arg_type);
 
-- 
2.34.1


