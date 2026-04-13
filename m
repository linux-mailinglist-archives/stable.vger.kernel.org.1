Return-Path: <stable+bounces-236971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCy0Jpoe3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71443EFE40
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAAF4303AB2B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F92EBB8C;
	Mon, 13 Apr 2026 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="z2Z8sp/k"
X-Original-To: stable@vger.kernel.org
Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515626B971;
	Mon, 13 Apr 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098261; cv=none; b=pL57lIdNbto0XpFvfszqZrcrvehsQenyYP8btwmXKH81WvfOhBY+D/i8d83H1T2lTxuw7YyhxN3FCJY2eeTtb/CQV8f5xQDOVsMFZVPiivGLHzAXqT0Agpf4BPoyz0UkHp9Tgz5M4k3aJFt71WrmQgrqc2ny+M1KcJLypLc0BvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098261; c=relaxed/simple;
	bh=Cq3m65wmdCoTsL2EgqXWtkPVmYG2XmTVGKJ8KDGed6U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=A+IA+nrgaCC5u365FVnaskSnXn/6uVUh/JLy6kZyq+EBQwK35oG6rOQOGUJZL/EvpE6CfmhGMStPsT3ueNOdMenFtQox9uXdwFhRfFjDJ7u/K4r4NHqN52RWEp2ecOvlGxZf/FVv4yNeRnMrWuT4t+tN1b6Kr0npX/KwLQxsl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=z2Z8sp/k; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID; bh=brUs+hkEeWZcARb8aww1+uhkG1L2CjQCnrEIxd4KeeA=;
	b=z2Z8sp/ksq3T4v3uFJbfvm42RktVCn/nOCjvNZLtEC6t/lOnFhIug4Z3rfcwRyGb9ra2PEpNrwylIH2/7YQ62sdtldJHUE6IMoPQF4nf7bfcYuhlW9ItYR7qv132ZPsL/rMI4qalacRbSNLhUQkjZE5LnFQ/2GfqnB54g2gt/MiwYX3+Fk8Cs0D6248Czmf08GzbSSW7YUGv3Erf+Q1tFf73PvepJF3YTwKkyuCSWx5TRoT+lAizhV55FcVH/j0yU+WVDxIxLjmL9mrwEY4eh7t8B1CajsnnI67R2zbe98vfR9QM9rbH9Iv2xvUWgqeSXQAALYoN93OdwbFz9TfB2g==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.13])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1wCJfY-0005tc-6O; Mon, 13 Apr 2026 17:57:48 +0200
Message-ID: <26d5dfb6-a898-469f-979e-5de6241a66f9@decentral.ch>
Date: Mon, 13 Apr 2026 17:57:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tim Tassonis <stuff@decentral.ch>
Subject: mmc card not recognized after 6.18.20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[decentral.ch:s=rsa2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[decentral.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[decentral.ch:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stuff@decentral.ch,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E71443EFE40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all

I hope this is the right list to report my problem.

I'm using the 6.18 series of kernels at the moment, and after 6.18.20, 
my mmc card is not recognized anymore.

I'm using the same config and compiler etc and assume that this is a 
known issue/expected behaviour, however, I did not find any results 
about this in Google.

I can of course provide more details about my configuration, if that helps.

Bye
Tim


