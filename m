Return-Path: <stable+bounces-267625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oQWiAnzzOGoBkgcAu9opvQ
	(envelope-from <stable+bounces-267625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA56ADC2F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=KPfb0Qlk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267625-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267625-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 018FF3041BB9
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890439060A;
	Mon, 22 Jun 2026 08:32:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED97390222
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:32:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117133; cv=none; b=BxSYjAvC4AtHqU5h1KuHyYh/kX5WNP5ocMAboFsqOrzBvD2WfcEPQNR6S8cZy9fMrPXgoGySBnwBvutxDxi6UNuH6NGMsgXnhNQY1XYUgJO9SnVM2RBn77e/+9ooB+a48nD/z7bICGKWHPdwQiZxJx+xccJGNHuBORc4Vd835bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117133; c=relaxed/simple;
	bh=CI9r8gXaJAJxDR/OSOHt5wIIPjuUUhwoEiqHNhKl8/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1PxO/OnP94UeGdBl562ueALQNwHUWPr/vaqJqm4xr+0u0mOAA4+1fJq3uQ1OeqUqsE6VLiUziOS1eN49pt/AX5+9cQHImP1mE/27vm9Fw/IKjHeHVFgFg7noI3ozaAYl6rhRpsABxPe9Bu0Bp/MJzPPB9QenapYUHA4FlYbe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPfb0Qlk; arc=none smtp.client-ip=95.215.58.170
Message-ID: <ae54f2e2-c53e-40ae-8016-bf8302236c88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782117129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XMCUdWNUTNxQ+9ZHfsfx1rhff+sOJFnxDlJ/S/dO+Q=;
	b=KPfb0QlkKAZcla/m1msSiD/Q3b06hIc5jEUOmF+RO2/tSrKJxZbuq4hvqnOM+U5bwS9nVL
	GNby/UkJZ564BXhs/sDkhvG0gxcthGULbOPT7lkeIlBp+vwUEe2VqRLkcCchM+4khUamlY
	91m+a8VjMqhp4fFF2bjIHTcdz4ORzkQ=
Date: Mon, 22 Jun 2026 16:31:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
 <F5EBCFC495955241+61489c47-c792-43de-a8f8-4b1030f4ab6a@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <F5EBCFC495955241+61489c47-c792-43de-a8f8-4b1030f4ab6a@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-267625-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DDA56ADC2F



On 6/22/26 4:24 PM, Peiyang He wrote:
> Hi Qi,
> 
> Thanks for confirming this bug and proposing the patch. The fix I previously proposed was indeed incorrect. I have applied your patch and tested it using the PoC script that previously triggered the warning; no warning is observed anymore.

Good news.

Thanks for testing this!



