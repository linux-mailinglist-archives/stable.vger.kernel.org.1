Return-Path: <stable+bounces-221761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKIQBE2co2l2IQUAu9opvQ
	(envelope-from <stable+bounces-221761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:54:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EF1CC340
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B2A3283520
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4942E5B09;
	Sun,  1 Mar 2026 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jz9jf955";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wf/IdZ3j"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926932D9798;
	Sun,  1 Mar 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329076; cv=none; b=YIGLvIGBJUsFb5b4Nkc16LCm21QcNce8y5jIxNpz6H4eMwDYNh/SBRRTsq9K8t63k/QktXayo4ElbncM2Ghj4xfkKX00zrlleUJ5af6IzNoo6ZHHG3VxBQAlPt+GcNZI5PBEx5OsM5E81Bi5VKHOzhDPVVIj4bph96bHxFRtzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329076; c=relaxed/simple;
	bh=BYdzQUQXUluLNpS/kygOSuGk/nZbOjcmhBlyHPtOvSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSXrAGZ1YYcORas8azrkBUGzGU4hdx0H5ZL+kgetCLE2GPIdMmjZowUjBCG/Bu8GbepCOktRfxnd7bLZFsvm/KeH6vapAOU26AegSEtr0zO3L2J5Sbe9JqDDchhGLp0rJRyKLoNZ//vuyUuQ8kbjiGtuju3qxLN+BaFK53QJHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Jz9jf955; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wf/IdZ3j; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fNl7N3YFmz9tR2;
	Sun,  1 Mar 2026 02:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772329072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmHJlRdWO7qOd4RDxTIAgF1+/4f6K+CEHnktCEN3TKM=;
	b=Jz9jf955eXg/mI4NHhMiXLxrckmPaJQvyNN37xq4pPC39BU2lSgMYVFPqej2Y5IWQH4fy9
	S9xYF8059POAxrgPr/oqqUa3uWQ1F9FiBtfLKIddMQN1Irzxb1St7xaNkmIdd4Dm62PUvz
	Zd8CQBWwwPnvyWz+qFe7o2kemeWWMLR86Tvygi+npmKwwJe7uwD1oq4Pjx89f06YVzHigT
	RG7qx/+cCVLAXm9YaXXxgc+4ek8hhnF7Q16KrparNRcBS/hQyicXVC8S5iSCENKNAHOMSg
	UcGzM/Vs6oNTMpUrxDX5K0Cx5TO3BX3m77DBQBbhA4MM4TDmataXibc5SslqrQ==
Message-ID: <e477a469-09c1-4e09-b951-c262a983ee7b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772329071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmHJlRdWO7qOd4RDxTIAgF1+/4f6K+CEHnktCEN3TKM=;
	b=wf/IdZ3jQfkzWP46xjtXBLhCs3pnO86X9DPY3OOjqchN6OLN3g0NOrX2QSX1zdaiqcWZw7
	WUsJCfZBKYGb4Yob++LzWgCu8xfsYK968PeXJCBTBjpYTgO659aIkchYO2YJdrVmQFEo2G
	0L4s1tMz+gO3GX2iF4M6ZXerNKggDiJksuVpcAtfWqotIpzbu74N2mo7NQ+hahqRM3c0pJ
	HLh05U6rxWlnduCuxYABLkMclSKbokEKshg5HnzAk0iRGP2ptl7r00KJ3P1/Ab5a04hVHP
	Tenwi4tD328xyFcy6MguYtNBrfkVjcZO6yK7En+JMdWgt8cEHteCKQByZA+kXg==
Date: Sun, 1 Mar 2026 02:37:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FAILED: Patch "clk: rs9: Reserve 8 struct clk_hw slots for for
 9FGV0841" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20260301012516.1682320-1-sashal@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260301012516.1682320-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nzkenmm1rdcax8bydyxxzu8uufdemdoa
X-MBO-RS-ID: b4bebc9cdd06493374a
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221761-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 777EF1CC340
X-Rspamd-Action: no action

On 3/1/26 2:25 AM, Sasha Levin wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
The cherry-pick worked out cleanly on 6.12.74, I also don't see anything 
that would prevent the patch from being applied, is there maybe another 
backport in the pipeline that is interfering with the application ?

