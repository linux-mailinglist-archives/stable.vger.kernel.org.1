Return-Path: <stable+bounces-249719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP/VC7oGDWpQsQUAu9opvQ
	(envelope-from <stable+bounces-249719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:56:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B25866BE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F06630A74BE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03A82D3750;
	Wed, 20 May 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfD9gp+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B0270EDF;
	Wed, 20 May 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238472; cv=none; b=Ey00DPOijUpP9qY3Evt1gpSZVFPyILJAkvTh1/wyhuyNjsmpB0PItFHuG3po+UQmbqRwYhkpRnLmv9gw1ZBfq4tRBF4zuwPaaObivPABzeNhcpwISKu+7H4AWxhkwYgdPIeSdN98+DOvdl8BbSX1m+3R9tj240EwnmZrzZW5vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238472; c=relaxed/simple;
	bh=0Q/oc3eDtrEW3u+qBQkPCNQ1jJz13KMrsbo+vJ8/bqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Eu8HEjv4WJKJu4pXTefJCeMrLG/vYgSQ/DR3ENNSZKBsnf6xqMFv9aiZYjO9uyiUeIUmSZolRnB3n/UaaY2xCiTeWKd1ulbUxT3jHv32sGnORD44tWDsyh2f3UmN+8EWQ4Fa66/71LUtiQU5/LdiqxVCQq7ClpowIYPegRjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfD9gp+A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACFB1F000E9;
	Wed, 20 May 2026 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238471;
	bh=0Q/oc3eDtrEW3u+qBQkPCNQ1jJz13KMrsbo+vJ8/bqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfD9gp+APa3jFTp0cwNhJaQCeG/Wen6PhxrxqJ1YWzavg0mdcB/O66YUGmHS1Mphv
	 /3+9/LBv0vZcYzUIlFn5NCTM7uhugidrKXmagphUBshr2s0zJYe0P/O71iNr9E2VTJ
	 wzHDWFqb0HxyjUalGopBqU6s5y3Cpoff6a4lKu9Hf1snPTVSiAkIK0mXhmPZ8bROZo
	 rUQia/BKYvCakYh3xoPzA6OLMTvKYFS5lhYkodzZ3XgmE8YLXQvHP0r+QLdIs9XnWE
	 6D0NbMWSitgZnxl6UjyXLOESn8DkSL/5MVIHC2npRAaFRlL17wap/UH4NVoH2itQoy
	 fmhAsVO9FDNmQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mateusz Redzynia <mateuszx.redzynia@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y] ASoC: SOF: Intel: hda: Fix NULL pointer dereference
Date: Tue, 19 May 2026 20:54:19 -0400
Message-ID: <20260519220508.reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_D2D615381730920DE9B46435691FBD92C708@qq.com>
References: <tencent_D2D615381730920DE9B46435691FBD92C708@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,intel.com,foxmail.com];
	TAGGED_FROM(0.00)[bounces-249719-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F4B25866BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:44:10PM +0800, Alva Lan wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>
> [ Upstream commit 16c589567a956d46a7c1363af3f64de3d420af20 ]
>
> If there's a mismatch between the DAI links in the machine driver and
> the topology, it is possible that the playback/capture widget is not
> set, especially in the case of loopback capture for echo reference
> where we use the dummy DAI link. Return the error when the widget is not
> set to avoid a null pointer dereference like below when the topology is
> broken.
[...]
> [ Minor context conflict resolved. ]
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>

Queued for 6.6, thanks.

--
Thanks,
Sasha

