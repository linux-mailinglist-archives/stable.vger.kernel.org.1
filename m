Return-Path: <stable+bounces-269767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JI+jDLR5Qmpu8AkAu9opvQ
	(envelope-from <stable+bounces-269767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:57:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B60506DB9E5
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=mBtDYa+N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269767-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269767-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41301301D77C
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAD319852;
	Mon, 29 Jun 2026 13:53:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD842EEE69;
	Mon, 29 Jun 2026 13:53:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741190; cv=none; b=JLVwL2+ozHJdIkOqT+0cHyzoMUwSCHlDqIbhrvzxta2aJDIMYmmrcxp2TRE2pxptVw+KImegmoQNbuO/BDZ49GpOUG4Vn0BJaDJalhMjsJXjH/BD7MhE2M92Oj2/r9HK4yLTd6vs0D86q6IPTi8x5MGgGQD1O8mqu7nMudpB7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741190; c=relaxed/simple;
	bh=lnB4yqZN5higwo+FbocY+bJA/QMc8Fx00nxu9JFZ4Jo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BlZs+YtgmU87ic45sTMQk2dNmhbzg1iT8PHy/HoCNV+yWKZ/KBZYP7v43XOi1YE/uzHjabytMh1kg5MX9JtAicDjajabUGbSyYGe6N9YtVX+tMLqUIjq2WCmBFanhAZhct5FrzCgyGZgtBDPE9DZ2Gw/isvbpbAuXrkBLfjvs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=mBtDYa+N; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782741187;
	bh=ts8JWNes5ZRZzzb0SQA7k3h7t9QaCSSjPcBO5U8rQNA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mBtDYa+NjFOb+O0dK2Hiz8D3EVreU2EAEYgKkzQTv32JYKB4KDhy2in/gzPAeL1X2
	 1LIUT8Il7gtGdgGdqNGIgDJR6H1v/CFi/qkBCw988wBrbW9QO3EkOgqbqlu7eL0O8S
	 Zskr2E9jQ3W1wk7zPlcplfqBQRNd5m/ekeB8WEfo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gpnmM2BVjz110s;
	Mon, 29 Jun 2026 13:53:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gpnmL6pPxz10xs;
	Mon, 29 Jun 2026 13:53:06 +0000 (UTC)
Date: Mon, 29 Jun 2026 14:53:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: Breno Leitao <leitao@debian.org>
CC: akpm@linux-foundation.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_lib/bootconfig=3A_fix_undefined_?=
 =?US-ASCII?Q?behavior_involving_NULL_pointer_arithmetic?=
In-Reply-To: <akJ0f2gsiEt01spu@gmail.com>
References: <20260628115617.3190-1-include@grrlz.net> <akJ0f2gsiEt01spu@gmail.com>
Message-ID: <0B594835-45AD-4B37-85A3-C7F54F8D668A@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:akpm@linux-foundation.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B60506DB9E5

On 29 June 2026 14:41:37 BST, Breno Leitao <leitao@debian.org> wrote:
>On Sun, Jun 28, 2026 at 11:56:16AM +0000, Bradley Morgan wrote:
>> When xbc_snprint_cmdline() is called during the size-probing phase
>> (with buf = NULL and size = 0), the function computes the end pointer
>> as 'buf + size' (NULL + 0) and repeatedly advances the pointer via
>> 'buf += ret'.
>> 
>> Under the C standard, performing pointer arithmetic on a NULL pointer is
>> undefined behavior. While harmless inside the kernel, this code is also
>> compiled into the userspace host tool 'tools/bootconfig', where host
>> compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
>> detect NULL pointer arithmetic.
>> 
>> Fix this by tracking the running written length as an integer offset
>> ('len') rather than advancing 'buf' directly. Only perform pointer
>> arithmetic if 'buf' is actually non-NULL.
>> 
>> Fixes: 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
>lib/bootconfig.c")
>
>Isn't commit 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
>lib/bootconfig.c") just a code movement?

Ugh, Geminis bullcrap, you are right. I should've just manually looked
for the fixes tag (as I always do)

>>  	xbc_node_for_each_key_value(root, knode, val) {
>> @@ -439,10 +437,12 @@ int __init xbc_snprint_cmdline(char *buf, size_t
>size, struct xbc_node *root)
>>  
>>  		vnode = xbc_node_get_child(knode);
>>  		if (!vnode) {
>> -			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
>> +			ret = snprintf(buf ? buf + len : NULL,
>> +				       size > len ? size - len : 0,
>
>Why not keeping rest() and updating it, instead of open coding it?
>
>Thanks for the fix.

sure I'll do V2, btw if u didn't read, gemini found and fixed this.
As in fully. :)



>--breno
>

Thanks!

