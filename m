Return-Path: <stable+bounces-247052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLCONpoLBWo1RwIAu9opvQ
	(envelope-from <stable+bounces-247052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:39:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847553C142
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B29943010F38
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D13CC32D;
	Wed, 13 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTdYvx5M"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4F3C8C65
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715536; cv=none; b=TeP5WbKLdxGGixAo3ks7G8bAPfDTzeOLrvTJT1q+GAbUbBrhAkduOUBJ+CTImlgAK6eCk3vL8aayFYCDRCRBeafiR5mevv+f9AlDt9hGKqh2+P/uDibQ9ssgfzaYbXhvet3BQ8yoDnNefL7jVLLeJ5hXnInVBkNkySCHDDqNZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715536; c=relaxed/simple;
	bh=oBAEVZATeASbH0nhe5drMl+9AytTIzOltLbIrseS608=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gps7bdPBVqKPCp/lSd9cJ+OZNij/MJbamx42YsJR1VhJLjldPFVh5xyysb4KmQDo9Jx3kEFa+gFfmrixsaab9bcD3/J7ZlUauOEc30ARy2pZJIKBcjMGLDYaiqyANaKbE++H15R3Egb7ln3MYhpzzAa91z4RpBr2H7J/eh3PkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTdYvx5M; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90d2acb9936so271814785a.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715534; x=1779320334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tPQGmLtEe0WJuWlk4o1gxSupMduAnwXuzQSwzyxZi4M=;
        b=pTdYvx5MO4zbPeh/PcIK5Gh1pZTloEHd+8KGbwCGZJj5Vopexg0esPVevrd7hZ3ens
         FBRnqm/cFBM77WHWpAvTsbuxe8G73LNFOuE8cS5wlrkgpkp7UhpfiKeYu+G3+fLKRPvY
         M+9uwmmfhBqnZbTBAXqLMd6CI8BbkvwOay11E8vabUCnUga8GczhJSMWiL7ZAbsAxGWN
         t5syL1QGav+fokBHNbx825t8KNxMD4mZ3+J0S3BB4mMWbo9pYfUeiYrph+Er+OzPvBz6
         b9B/IfWlkEF80jgrvJgyDU76QmC2jhLgE5nrrMNbdke81ELQH9U+LNSlDsuezWxXI7cz
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715534; x=1779320334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPQGmLtEe0WJuWlk4o1gxSupMduAnwXuzQSwzyxZi4M=;
        b=hLQ2pbkuRi+pnrnzVyxbltJZVXLEFeC2gwmv9MXcpU152//mhv6gcXyXGyRUQMOzO3
         EyTB/akrEv/jgbnTv47xYnc6RQJUlROtgFLoOSTSuDOpwE+QsTMfqKwcSrVCJsBCPurS
         mb3YYBm1r/WBkI5BFr2B4DPML8Wop0L34LnRaCdswQgY/OluIBTtJ4bMyVq+epc+babZ
         SBqVZorvZIWElawgBroQ9XuIC8wWgSJ3xKiQ71XNzn5JQ/10kIONDXC4Yg/r/tfazDpv
         tqwxmzYXOTZsBoEPAmPupQhc6FVvN3DLfSMSWO6O8+spVp5ItPuwLObc64ld6P60ZQo0
         IVNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n/Ur3cz7ARio8WMqQUwZdVl0CivClKVE5QAqo1p8rkSx08QWZ5It6o4aieG7T3cg9lyiwrak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvm5FUrBVXnMe7NzAQlpONZIKi5dtxG2LoZuAJEW6dDBsqmVyP
	5I+ktbmbPwTFFwlyh2zxjW+7eGBdnaVGLiDIW2R9aM0GzIahN8lerjfN
X-Gm-Gg: Acq92OEYJdyQdLs5Ogi4VKnkJctMbU0BXRuqLRc1+qHfG7yUhoABnZ4ntkdlQMXnkCb
	+GqW2jTDqbsbToaYNln73eHRHZDikdhz1cACWYkL/XR74y3CylAkkXzOuQq0S5nX0WqNlTIGx6W
	tMKsp+Nt4WFjbk9Z2OOChAjQ/a6iqRg1z5QkOAnqh3QMALnreFNjP2C2jCNTfusKuRNwrRxAafB
	F2xQmx0NI7wSN5h568V+GVsF89MfCn4TQHVREaNZtkqkt7+8GoXJnDzWfpquodY/EzUVnKNoL5K
	bhd5FjBDO6M7xWdd4RE7MyytxW+7nTzRcZp9c2Lex+MW46uarHr44rmt5FQ9ReeY88r3j2ppXqt
	+NLkwkclRGmDYY0mLainaQx0foU+J1xwlhfiFkgg3eFEBYAwR9ta40yjrUbzeIMSYz3iv8qyw3J
	JmKgPVcrm26pcr4JNRYKaOjz3OsxjMo4snzg/JMLF5wcTNkdPSoJ+GTADwPiCFmSNmN8tZKspHn
	A6r1FDlZeYrmsNTLTU9LDd1DGO3NCk1/W9VtZ7b+tE=
X-Received: by 2002:a05:620a:1a1a:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-90fab222fedmr756739285a.9.1778715533884;
        Wed, 13 May 2026 16:38:53 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm94186085a.20.2026.05.13.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:38:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luka Gejak <luka.gejak@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/1] net: hsr: fix node-table UAF on device teardown
Date: Wed, 13 May 2026 19:38:37 -0400
Message-ID: <20260513233838.3064715-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2847553C142
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,linutronix.de,linux.dev,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247052-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

HSR generic-netlink node-list/status readers walk hsr->node_db under
rcu_read_lock(), but RTM_DELLINK teardown frees the same node table
immediately via plain list_del() + kfree(). A reader that has already
obtained a struct hsr_node can race hsr_dellink() and dereference
freed node memory.

The patch below uses list_del_rcu() and the existing
hsr_free_node_rcu() callback in hsr_del_nodes(). The HSR prune paths
already use this lifetime rule for the same node_db.

Reproduction.

  The natural reader window between hsr_get_next_node() acquiring
  a node and ether_addr_copy() consuming it is short, so I widened
  it with a temporary udelay() in hsr_get_next_node() and
  hsr_get_node_data() (debug-only, not in this submission). Under
  x86_64 KVM with KASAN, an in-netns RTM_NEWLINK / parallel-readers
  / RTM_DELLINK loop then produces:

    BUG: KASAN: slab-use-after-free in hsr_get_next_node+0x1db/0x350
    Read of size 6 at addr ffff888009e6f290 by task hsr_genl_spam/...
    Freed by task ip:
      hsr_del_nodes+0x144/0x250
      hsr_dellink+0x6c/0x90
      rtnl_dellink+...

  The reader walks node_db under rcu_read_lock() while hsr_dellink()
  -> hsr_del_nodes() removes and immediately frees the entries.

  Without the artificial widening the race is still real but the
  observable window is ns-to-us scale, which is presumably why
  syzbot has not flagged it in the open. The fix is the same
  either way: honour the RCU lifetime that the prune paths
  already use.

Testing.

  - net/hsr/hsr_framereg.o builds clean on an x86_64 KASAN config.
  - With the widening patch applied on top of this fix, 50 rounds
    of the RTM_NEWLINK / parallel-readers / RTM_DELLINK harness
    run KASAN-silent. The same harness fires the splat above on
    the unpatched tree in the first round.
  - Without the widening, 100 rounds of the same harness in
    list-readers mode run clean on the patched kernel.
  - tools/testing/selftests/net/hsr/{hsr_ping,prp_ping,hsr_redbox}.sh
    -4 all pass on both stock and patched kernels, diff-clean.
  - scripts/checkpatch.pl --strict is clean.

A separate status-path NULL deref in hsr_get_node_data() shows up
when the same harness runs with status readers and the widening
patch. That predates this fix and is not addressed here; I will
send it as its own patch once the primitive is characterised.

This targets net and carries a stable tag back to the dellink
cleanup commit b9a1e627405d.

Michael Bommarito (1):
  net: hsr: defer node table free until after RCU readers

 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 8d90b09e6741f5103ccc81a53bf2391ea09419a7
--
2.53.0


