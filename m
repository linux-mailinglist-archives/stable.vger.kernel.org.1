Return-Path: <stable+bounces-269909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k2w6Ih1+Q2ouZQoAu9opvQ
	(envelope-from <stable+bounces-269909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:28:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03316E1A79
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:28:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=atmark-techno.com header.s=gw2_bookworm header.b=OhMH3War;
	dkim=pass header.d=atmark-techno.com header.s=google header.b="jlmMCW/l";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269909-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269909-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=atmark-techno.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F35304C063
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8683B4E9A;
	Tue, 30 Jun 2026 08:27:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BE38D006
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808053; cv=none; b=t2qtlLbnkuvTWUqP4S6xbfqZ5KMnbSb0tXJujW2WAsYzN5d1fD4mmLjlapZ+RV6717QwZRUMBG5Uarqmvum/oxzG3+3DQdQMRbZBO7cnztyiYwr+9C9+eH96hn4YopjSMaJyBFNsLYdvyLuLaVj2sXn5HIVVnuAL3ORbZs/bd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808053; c=relaxed/simple;
	bh=0AqV/YDHGn19EMEu1E1okmOUiWZzYKdDuUHqmTFfw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQjXt+W/Fm3SR0+yLM5CA2aLvgjR6OoSfCpaSVqhPL+X+0DdnqJXavdCGI690pvdAWvx3YfvrGC+d3p8rOsCKCSYRqwSmkfa1jQh99HMyCGvlAYz4URe++9+UCxY7tFerSSq2WPQOxUjZ5P2JPyvR10+0EuFAThqOZrAHv0nJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=OhMH3War; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=jlmMCW/l; arc=none smtp.client-ip=35.74.137.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1782808050;
	bh=0AqV/YDHGn19EMEu1E1okmOUiWZzYKdDuUHqmTFfw3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhMH3WarNc4+1DHPQVYNJabTzFK792Sh/uTC4VUlNZwsce91W7p5PxxMId2ph/qqN
	 i5vVGtiLWsqEDaWsI/0Q9pDuFLv57qWpc9mZlQVKm+/brTYWv1grHySN8UOtQJLeBj
	 z13Qph6Mrfdo2xpl7j9dOTZvwrdGFD/8CWIA7KOVhgLLYU26oVwUFDWsWN9BdpF1z/
	 5vJScSvXekNQPKTXBK9qNCvwUDGc1MSPwjOY7DhvRI3lNhTR4z2pqYFreRlG8XbqIs
	 kbjMh59HGXq78V7gAaVoxBPL5vvADcmhNN1jBoWUrSXb4cpIqOhzAI6Fwf4x/maF4w
	 tQPSzZIXDO+ow==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 4D0CF366
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:27:30 +0900 (JST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 3AC73433
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:27:28 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845df469a26so4156297b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1782808047; x=1783412847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElN0E0Vc646AHHC1/cI4G5asPGbZj5VC1KY8MtG3QEI=;
        b=jlmMCW/lM4FJ61iWKO1/pLO+ZJngdd2cQ3wu4+/iutFnbobPKekYiy/ytfM3nfhSk9
         NpxGnYzO4XvwsRl2E5fDg72OA0LLlQrYqDR+qvbJADlaWeA0rj07cPvKces9T++/pVzL
         4jYZHtITnXHdo1FMPGqe5kDQ+8Ufu5NsZb4NXr42lY0vkqa3TLRxhEUbZDUbSrmLEvgZ
         SJLXQxJJ11y4sNHyvbDJ3MQXF20r+JbgbTg2NOL4fyct849cyl+8AHjULiVUNsSZkBg+
         oaoEifIcY6Yfq+NgOnt0fNpO3GRQJjntImfydP1p8i1jjfvGjSqMP3MHbEZ0rivZVLDY
         mJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808047; x=1783412847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElN0E0Vc646AHHC1/cI4G5asPGbZj5VC1KY8MtG3QEI=;
        b=p95VMvZlereoXJ58xAnOjlmpJd8GctMXaT/2dWwQqJ29IFHT/sBaTT9+iwpvfKIum8
         csw1IBbtAoIgzvMx8lJ+2XWZMd9btW26kXu04li0jGjbKrSEWzP/HIP9BWzZo9pSNfM3
         COcMCQ9dA11AMRf5tvoARlHz5Zh0o2Z6qF+8Jk0L4Z5qjRAbEygHb1aDTgz38tPNSOS/
         5P3bFWIBLQAm3A2Zmf+VxC7UwC6jY6tFoUdbbhRT3yulWtV4gq0PH8hTVCTCGqG8SJEc
         3puEAQciHx4GHCGXCcFQkXuSdtBCGwr7oVQ0An6RbUowRBxjN2o9qANWUIfm1Q2IClGd
         DbSg==
X-Forwarded-Encrypted: i=1; AFNElJ/vg6F/shwrznxOTsYaPD/GosqWCWx1W2o2ulYlicVoWhUHonrot/x4BNVcvvP1F2sH7innQ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVp5OaApvqXie8s6NYwRf6ZTN6a3fucGL3eEeefmPkCr7hdj4
	WOwxjOFLRbSp8p2Rap/fyaquddMMb9T7IFyg1jc9T8/rdnQxzwCeiPuI7TY1ShShO/ggxUZa+hs
	DQNMcM6l/XQeTyYKN7iSkfpW3GodsKxHNYS4Dr2mrf118ShoNmo11me68I8s=
X-Gm-Gg: AfdE7clC7hMbF6ajQOLkEVtCU4ukg2HWAugz7I+G+xTPxotUgZ09HLJzpjrzcpjOQQ7
	BUaJIlUOIXqUZGjnyybGOCdKFR6ehRmn2F/pHiYb93VZ9HzpJFwH5p3F+2m1TOjH2SuQ+QtbmcT
	c4ThqdTI2jqcwJ2GAGcGpsGD4uT6gBKQivLTCg5KqMYKAoxMRqjmB0taBCJ35eWt78nyFL/8CZU
	rq4oxDkQT85g/Z8Y6kswnTCfkQrhX6/BCv5OecxuvF47Dcsfro86chMxsArwR+T27PE3fxu6cQB
	6EnbY3mOtBfZ/Tfn7wDgj9A7bpWJco0y6Dg/qSR1DxxlzqDDt3LFvs2qTgkb8TaxTV/9C0lqsVX
	5wTrAZn3Vu+i1GXrQvPgzZToYohyo41Le8we60mjK9Tkv7NrWPrS1wSlFR9A=
X-Received: by 2002:a05:6a00:94c9:b0:847:927d:47a8 with SMTP id d2e1a72fcca58-8479eef1e06mr2334517b3a.18.1782808047166;
        Tue, 30 Jun 2026 01:27:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:94c9:b0:847:927d:47a8 with SMTP id d2e1a72fcca58-8479eef1e06mr2334489b3a.18.1782808046677;
        Tue, 30 Jun 2026 01:27:26 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-847a0007464sm1371506b3a.23.2026.06.30.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:27:26 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: dominique.martinet@atmark-techno.com,
	stable@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	=?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH 5.10.y] net/sched: fix pedit partial COW leading to page cache corruption
Date: Tue, 30 Jun 2026 17:27:08 +0900
Message-ID: <20260630-cve-2026-46331-v1-2-c1986f356f26@atmark-techno.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630-cve-2026-46331-v1-1-c1986f356f26@atmark-techno.com>
References: <20260630-cve-2026-46331-v1-1-c1986f356f26@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260630-cve-2026-46331-4f851ccf8244
X-Developer-Signature: v=1; a=openpgp-sha256; l=8877; i=dominique.martinet@atmark-techno.com;
 h=from:subject:message-id; bh=oqcZ/f4/98migEijhvNaC5FLNfmO9L/opKQ1jbIHVBc=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqQ3f7YjUi3XnzjgCFJQqCGn8HEiwjWqbnoJh3M
 zcb0dWRnEKJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCakN3+wAKCRDyimB/1oxx
 B563D/9M43LiusPq/K+A89lE25NeUV+YZF2e7L6IpUbQVFAaL5RZtY+BufA4YYTavenpmG8ULTl
 yU75Jb95mk0oGc8wdmxcZBbinh24dkxV164Ri1meSeWNfSetPzC+WlbtMb/kEZaQRxNTLdCmmb2
 gR5/0q92SsQQ2iSJ7m3OwiHmOOUAW7S892mXei5ApkC5sJYLqwpZo9euzWFqH4APwNG0/yx3MAN
 16DkhYXSTtDrripzoNEkMN+2hP3H46g3s77Ho8a+j6tBOfWZ0msqgYMA40qvG/WNcpcX8t3MPgY
 Ss4rEauiwbw1aNWz164s6U7+rY87nXY+7CtUhk7nYmCDKe9uGTGW4LeO+f+OyjTrwpF3vgdqU0n
 MqFRNpKbNk7NIGadMTWhCf0YS7qijz7zjMuTYWfgosZIs9CtgBcEN6upfon+B6oe6gWOR1bTxmg
 l3A6dfU2hSN9jEqt2K2jJ7ukkAwrqe+DAYzmcmUjau65Wm0sMzdEITIRVYeJN2ld1vmvLNzuGpE
 LUB8gc9Is1T/vnpWTEdEgH5vgl7A/aAdUSHyoTxzuFIezKG42jc74YtVWzCLyWqY5i3+ncM9b95
 b7TGZYWYaBLI1lLWb1D6DkXBvKyX3adIHEKT6WdziyAuH+ery0nTcIXI0bdlXr2y0gB+B6fZ/Zc 8wumq8nZdU91lqA==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp; fpr=2815288B303FADC6BD2F7896F28A607FD68C7107
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[atmark-techno.com,none];
	R_DKIM_ALLOW(-0.20)[atmark-techno.com:s=gw2_bookworm,atmark-techno.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,atmark-techno.com:dkim,atmark-techno.com:email,atmark-techno.com:mid,atmark-techno.com:from_mime,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email];
	FORGED_RECIPIENTS(0.00)[m:dominique.martinet@atmark-techno.com,m:stable@vger.kernel.org,m:jhs@mojatatu.com,m:xiyou.wangcong@gmail.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:mathew.j.martineau@linux.intel.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rajat.gupta@oss.qualcomm.com,m:yimingqian591@gmail.com,m:keenanat2000@gmail.com,m:2045gemini@gmail.com,m:rollkingzzc@gmail.com,m:dcaratti@redhat.com,m:toke@redhat.com,m:victor@mojatatu.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dominique.martinet@atmark-techno.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,linux.intel.com,redhat.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominique.martinet@atmark-techno.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[atmark-techno.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D03316E1A79

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>=0D
=0D
[ Upstream commit 899ee91156e57784090c5565e4f31bd7dbffbc5a ]=0D
=0D
tcf_pedit_act() computes the COW range for skb_ensure_writable()=0D
once before the key loop using tcfp_off_max_hint, but the hint does=0D
not account for the runtime header offset added by typed keys. This=0D
can leave part of the write region un-COW'd.=0D
=0D
Fix by moving skb_ensure_writable() inside the per-key loop where=0D
the actual write offset is known, and add overflow checking on the=0D
offset arithmetic. For negative offsets (e.g. Ethernet header edits=0D
at ingress), use skb_cow() to COW the headroom instead. Guard=0D
offset_valid() against INT_MIN, where negation is undefined.=0D
=0D
Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writab=
le")=0D
Reported-by: Yiming Qian <yimingqian591@gmail.com>=0D
Reported-by: Keenan Dong <keenanat2000@gmail.com>=0D
Reported-by: Han Guidong <2045gemini@gmail.com>=0D
Reported-by: Zhang Cen <rollkingzzc@gmail.com>=0D
Reviewed-by: Han Guidong <2045gemini@gmail.com>=0D
Tested-by: Han Guidong <2045gemini@gmail.com>=0D
Reviewed-by: Davide Caratti <dcaratti@redhat.com>=0D
Tested-by: Davide Caratti <dcaratti@redhat.com>=0D
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>=0D
Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>=0D
Reviewed-by: Victor Nogueira <victor@mojatatu.com>=0D
Tested-by: Victor Nogueira <victor@mojatatu.com>=0D
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>=0D
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>=0D
Link: https://patch.msgid.link/20260531123221.48732-1-jhs@mojatatu.com=0D
Signed-off-by: Jakub Kicinski <kuba@kernel.org>=0D
[Dominique: plenty of context conflict but the code itself could still=0D
mostly be used]=0D
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>=0D
---=0D
(Sorry for double-send to stable@vger, I hadn't intended to send the=0D
Cc-free version...)=0D
=0D
CVE-2026-46331 got attention and I've had to backport this to 5.10, so=0D
here we are, this should fix it.=0D
=0D
Unfortunately there are more conflicts with 5.15 so I didn't do this=0D
one (but if anyone cares older 5.4/4.19 cherry-picks cleanly from this,=0D
they're no longer stable kernels so I won't bother sending)=0D
=0D
I've tested in egress with a trivial rule redirecting port inspired from=0D
the man page (and checking on target with tcpdump because return path is=0D
broken), so I hopefully didn't botch this too badly:=0D
=0D
tc qdisc replace dev eth0 root handle 1: htb=0D
tc filter add dev eth0 parent 1: u32 match ip dport 23 0xffff action pedit =
pedit munge ip dport set 22=0D
---=0D
 include/net/tc_act/tc_pedit.h |  1 -=0D
 net/sched/act_pedit.c         | 84 ++++++++++++++++++++++-----------------=
----=0D
 2 files changed, 43 insertions(+), 42 deletions(-)=0D
=0D
diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h=
=0D
index 3e02709a1df656931942be4851a115dd6bef8b4c..748cf87a4d7ea5c92b4fd48dd33=
02b8ad64944fe 100644=0D
--- a/include/net/tc_act/tc_pedit.h=0D
+++ b/include/net/tc_act/tc_pedit.h=0D
@@ -14,7 +14,6 @@ struct tcf_pedit {=0D
 	struct tc_action	common;=0D
 	unsigned char		tcfp_nkeys;=0D
 	unsigned char		tcfp_flags;=0D
-	u32			tcfp_off_max_hint;=0D
 	struct tc_pedit_key	*tcfp_keys;=0D
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;=0D
 };=0D
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c=0D
index a44101b2f441919b7d4b0be177aa735a3c547350..cebeed6214558b1e1dd717b411c=
9ffa108a2293d 100644=0D
--- a/net/sched/act_pedit.c=0D
+++ b/net/sched/act_pedit.c=0D
@@ -14,6 +14,8 @@=0D
 #include <linux/module.h>=0D
 #include <linux/init.h>=0D
 #include <linux/slab.h>=0D
+#include <linux/overflow.h>=0D
+#include <asm/unaligned.h>=0D
 #include <net/netlink.h>=0D
 #include <net/pkt_sched.h>=0D
 #include <linux/tc_act/tc_pedit.h>=0D
@@ -229,21 +231,11 @@ static int tcf_pedit_init(struct net *net, struct nla=
ttr *nla,=0D
 		p->tcfp_nkeys =3D parm->nkeys;=0D
 	}=0D
 	memcpy(p->tcfp_keys, parm->keys, ksize);=0D
-	p->tcfp_off_max_hint =3D 0;=0D
 	for (i =3D 0; i < p->tcfp_nkeys; ++i) {=0D
-		u32 cur =3D p->tcfp_keys[i].off;=0D
-=0D
 		/* sanitize the shift value for any later use */=0D
 		p->tcfp_keys[i].shift =3D min_t(size_t, BITS_PER_TYPE(int) - 1,=0D
 					      p->tcfp_keys[i].shift);=0D
 =0D
-		/* The AT option can read a single byte, we can bound the actual=0D
-		 * value with uchar max.=0D
-		 */=0D
-		cur +=3D (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;=0D
-=0D
-		/* Each key touches 4 bytes starting from the computed offset */=0D
-		p->tcfp_off_max_hint =3D max(p->tcfp_off_max_hint, cur + 4);=0D
 	}=0D
 =0D
 	p->tcfp_flags =3D parm->flags;=0D
@@ -277,15 +269,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)=0D
 	kfree(p->tcfp_keys_ex);=0D
 }=0D
 =0D
-static bool offset_valid(struct sk_buff *skb, int offset)=0D
+static bool offset_valid(struct sk_buff *skb, int offset, int len)=0D
 {=0D
-	if (offset > 0 && offset > skb->len)=0D
+	if (offset < -(int)skb_headroom(skb))=0D
 		return false;=0D
 =0D
-	if  (offset < 0 && -offset > skb_headroom(skb))=0D
-		return false;=0D
-=0D
-	return true;=0D
+	return offset <=3D (int)skb->len - len;=0D
 }=0D
 =0D
 static int pedit_skb_hdr_offset(struct sk_buff *skb,=0D
@@ -325,18 +314,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 			 struct tcf_result *res)=0D
 {=0D
 	struct tcf_pedit *p =3D to_pedit(a);=0D
-	u32 max_offset;=0D
 	int i;=0D
 =0D
 	spin_lock(&p->tcf_lock);=0D
 =0D
-	max_offset =3D (skb_transport_header_was_set(skb) ?=0D
-		      skb_transport_offset(skb) :=0D
-		      skb_network_offset(skb)) +=0D
-		     p->tcfp_off_max_hint;=0D
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))=0D
-		goto unlock;=0D
-=0D
 	tcf_lastuse_update(&p->tcf_tm);=0D
 =0D
 	if (p->tcfp_nkeys > 0) {=0D
@@ -347,10 +328,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 		enum pedit_cmd cmd =3D TCA_PEDIT_KEY_EX_CMD_SET;=0D
 =0D
 		for (i =3D p->tcfp_nkeys; i > 0; i--, tkey++) {=0D
-			u32 *ptr, hdata;=0D
+			int write_offset, write_len;=0D
 			int offset =3D tkey->off;=0D
 			int hoffset;=0D
-			u32 val;=0D
+			u32 cur_val, val;=0D
+			u32 *ptr;=0D
 			int rc;=0D
 =0D
 			if (tkey_ex) {=0D
@@ -369,13 +351,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 =0D
 			if (tkey->offmask) {=0D
 				u8 *d, _d;=0D
+				int at_offset;=0D
 =0D
-				if (!offset_valid(skb, hoffset + tkey->at)) {=0D
-					pr_info("tc action pedit 'at' offset %d out of bounds\n",=0D
-						hoffset + tkey->at);=0D
+				if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||=0D
+				    !offset_valid(skb, at_offset, sizeof(_d))) {=0D
+					pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",=
=0D
+							    hoffset + tkey->at);=0D
 					goto bad;=0D
 				}=0D
-				d =3D skb_header_pointer(skb, hoffset + tkey->at,=0D
+				d =3D skb_header_pointer(skb, at_offset,=0D
 						       sizeof(_d), &_d);=0D
 				if (!d)=0D
 					goto bad;=0D
@@ -387,23 +371,44 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 				goto bad;=0D
 			}=0D
 =0D
-			if (!offset_valid(skb, hoffset + offset)) {=0D
-				pr_info("tc action pedit offset %d out of bounds\n",=0D
-					hoffset + offset);=0D
+			if (check_add_overflow(hoffset, offset, &write_offset)) {=0D
+				pr_info_ratelimited("tc action pedit offset overflow\n");=0D
 				goto bad;=0D
 			}=0D
 =0D
-			ptr =3D skb_header_pointer(skb, hoffset + offset,=0D
-						 sizeof(hdata), &hdata);=0D
-			if (!ptr)=0D
+			if (!offset_valid(skb, write_offset, sizeof(*ptr))) {=0D
+				pr_info_ratelimited("tc action pedit offset %d out of bounds\n",=0D
+						    write_offset);=0D
 				goto bad;=0D
+			}=0D
+=0D
+			if (write_offset < 0) {=0D
+				if (skb_cow(skb, -write_offset))=0D
+					goto bad;=0D
+				if (write_offset + (int)sizeof(*ptr) > 0) {=0D
+					if (skb_ensure_writable(skb,=0D
+								min_t(int, skb->len,=0D
+								      write_offset + (int)sizeof(*ptr))))=0D
+						goto bad;=0D
+				}=0D
+			} else {=0D
+				if (check_add_overflow(write_offset, (int)sizeof(*ptr),=0D
+						       &write_len))=0D
+					goto bad;=0D
+				if (skb_ensure_writable(skb, min_t(int, skb->len,=0D
+								   write_len)))=0D
+					goto bad;=0D
+			}=0D
+=0D
+			ptr =3D (u32 *)(skb->data + write_offset);=0D
+			cur_val =3D get_unaligned(ptr);=0D
 			/* just do it, baby */=0D
 			switch (cmd) {=0D
 			case TCA_PEDIT_KEY_EX_CMD_SET:=0D
 				val =3D tkey->val;=0D
 				break;=0D
 			case TCA_PEDIT_KEY_EX_CMD_ADD:=0D
-				val =3D (*ptr + tkey->val) & ~tkey->mask;=0D
+				val =3D (cur_val + tkey->val) & ~tkey->mask;=0D
 				break;=0D
 			default:=0D
 				pr_info("tc action pedit bad command (%d)\n",=0D
@@ -411,9 +416,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const str=
uct tc_action *a,=0D
 				goto bad;=0D
 			}=0D
 =0D
-			*ptr =3D ((*ptr & tkey->mask) ^ val);=0D
-			if (ptr =3D=3D &hdata)=0D
-				skb_store_bits(skb, hoffset + offset, ptr, 4);=0D
+			put_unaligned((cur_val & tkey->mask) ^ val, ptr);=0D
 		}=0D
 =0D
 		goto done;=0D
@@ -425,7 +428,6 @@ static int tcf_pedit_act(struct sk_buff *skb, const str=
uct tc_action *a,=0D
 	p->tcf_qstats.overlimits++;=0D
 done:=0D
 	bstats_update(&p->tcf_bstats, skb);=0D
-unlock:=0D
 	spin_unlock(&p->tcf_lock);=0D
 	return p->tcf_action;=0D
 }=0D
=0D
---=0D
base-commit: d9666dca97c01de1c7395ac53041634eb75120e2=0D
change-id: 20260630-cve-2026-46331-4f851ccf8244=0D
=0D
Best regards,=0D
-- =0D
Dominique Martinet <dominique.martinet@atmark-techno.com>=0D
=0D



