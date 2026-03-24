Return-Path: <stable+bounces-230078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IHxMQ1LwmnvbAQAu9opvQ
	(envelope-from <stable+bounces-230078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:27:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD63049B7
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FC10303BACF
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364E3ACF1A;
	Tue, 24 Mar 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="X7yMW9mv"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF936C9E1;
	Tue, 24 Mar 2026 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340526; cv=none; b=DO3Q7GuRFgSlU0mTboshGjUT/xvrizeYJWdpWHpMYlvNf8NH0rHRVzxxmMlq0R4Dr4Ra0SLWU+uHk7N6yfE2CoB51H4vz4mN3p+A609FEQluLzH077IfzhHZuZJ7rhinws8hBZDJEqYMcSbdwqjezrV7Nd9mMxIAJ6AFf1SN5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340526; c=relaxed/simple;
	bh=8grPAK9Rb5KRyYqvt/gc3dmMhk51g3vCY3wNxVaOnlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+7C2TKcqUgiqV4Bo5A9I8HmYU4ce3ZPzUtGSDgwwegLqaZErzzY1opZW9hBwDOat9I1D/nIitoHJ7gnxUukAaXP40+dmvLaJWhGYf+8qlwDQEXyWBfen1Sd2wIciPFDJdEjrK1W7hWWYd122/1+ch7+2UoYVje9Nu49gmFMrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=X7yMW9mv; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=X7yMW9mv9qy/+jV/ulYXoYfVBo+1kTueslE+836Q8HLcKuXmHBvUcvxPZehjLRiImw3o4EVJJIuc7
	 bJf1esNvFaRsBFeoBkrQZv3E79Aq5YHCjHMhiE7kl/9B66QrUyL6VOkJ3ZHoyQfSi+f3HQQqjSysfr
	 2UO7Lea4IGAWKzBQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[2409:8A00:DD3:9760:10A3:2606:149F:AFFC])
	by rmsmtp-lg-appmail-19-12022 (RichMail) with SMTP id 2ef669c249927e1-0180f;
	Tue, 24 Mar 2026 16:21:55 +0800 (CST)
X-RM-TRANSID:2ef669c249927e1-0180f
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y 2/2] cpufreq: Avoid a bad reference count on CPU node
Date: Tue, 24 Mar 2026 16:21:13 +0800
Message-ID: <20260324082113.6275-2-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324082113.6275-1-lanbincn@139.com>
References: <20260324082113.6275-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linaro.org,intel.com,139.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230078-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.925];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,139.com:email,139.com:mid]
X-Rspamd-Queue-Id: B4DD63049B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Miquel Sabaté Solà <mikisabate@gmail.com>

[ Upstream commit c0f02536fffbbec71aced36d52a765f8c4493dc2 ]

In the parse_perf_domain function, if the call to
of_parse_phandle_with_args returns an error, then the reference to the
CPU device node that was acquired at the start of the function would not
be properly decremented.

Address this by declaring the variable with the __free(device_node)
cleanup attribute.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20240917134246.584026-1-mikisabate@gmail.com
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Minor context conflict resolved. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 include/linux/cpufreq.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8e3a1d4e0a3a..6ed4c82af367 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1014,11 +1014,10 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 static inline int parse_perf_domain(int cpu, const char *list_name,
 				    const char *cell_name)
 {
-	struct device_node *cpu_np;
 	struct of_phandle_args args;
 	int ret;
 
-	cpu_np = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_np)
 		return -ENODEV;
 
@@ -1027,8 +1026,6 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 	if (ret < 0)
 		return ret;
 
-	of_node_put(cpu_np);
-
 	return args.args[0];
 }
 
-- 
2.43.0



