Return-Path: <stable+bounces-172900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A1B3506D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8363F167701
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 00:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368625A2A1;
	Tue, 26 Aug 2025 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tezzYRy/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305191F0E50;
	Tue, 26 Aug 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169038; cv=none; b=iJREjNaSkoVB2y6Uf30DVz3TADdI5hThKngmESLxtEEXNyQ903jP4EdkZNoUWRbfZ1USLTIMNgJBXHLYRtCMraPuYCfOYPMfrKPBEiOXnpXhraDLJlFqRuiMgy2ZT/wiYZyH3MlQA0hU6F07KZhs4fTaKBfzgBoJfRKbdC7qtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169038; c=relaxed/simple;
	bh=kgEm7y9mI2RqhU0ZW11hilEZhK6+VRmDl9FN6hfk11g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVf7IaolidvnEj563hTe2x6dQKBt03T8xdyFUcmo0c62JIcSxYAkibCgagaoVs5w2pYoQlrBvX80qITo+VWGDHVN07mog14uUjMaNV5MkfEt7+lzt0b+7gYP1m/SIHZo958t5B5o5oJpUFx0H0KWhrhMV/AikNmab8GmhgrB55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tezzYRy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE2C4CEED;
	Tue, 26 Aug 2025 00:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756169037;
	bh=kgEm7y9mI2RqhU0ZW11hilEZhK6+VRmDl9FN6hfk11g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tezzYRy/+aSLU2KprUvNXWxTWRKiVjSRh26jwAi4Ebt8ehIlaSGA8WxOFjX89Ywc4
	 B5hOrBpZ6FQLgTL5CS6+5PkUPBWrRQYNTw51uFR20k6FG79JALOYvtS1hqP4HO+3zU
	 HxgeAXE2oiKDjlZzXHyKnbrTeIC+Qyy3jamywquIJrT3tRAcfhSF68HM4+IY6k9sws
	 q3eP4zASZt+SCKW5fftt10BkTjkXcvFTIqTQaQ566DIKOl8TuTsoORd3Y/ODfNHw6b
	 NQMcFL0bOExa39duNOIX3QIT3YxGfY3dwJWBoc20+wr3QynT35Y7AGQSLhvndYeu0j
	 h4gc2kMOcvaHg==
Date: Mon, 25 Aug 2025 17:43:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/dccp: validate Reset/Close/CloseReq in
 DCCP_REQUESTING
Message-ID: <20250825174356.54d8ff11@kernel.org>
In-Reply-To: <20250824083653.1227318-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20250824083653.1227318-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 16:36:53 +0800 Yizhou Zhao wrote:
> This fix should apply to Linux 5.x and 6.x, including stable versions.
> Note that DCCP was removed in Linux 6.16, so this patch is only relevant
> for older versions. We tested it on Ubuntu 24.04 LTS (Linux 6.8) and
> it worked as expected.

You need to make it clearer that this submissions is for stable *only*.
As you say this code doesn't exist upstream any more.
-- 
pw-bot: nap

