Return-Path: <stable+bounces-80769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A099090D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267601C2204C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8511E377D;
	Fri,  4 Oct 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I1vbeiKc"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE921C729C
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059047; cv=none; b=C+Prd0BPC64iK9ts5nU1aGhp0WSsifMEipxoxOot5Ey+6s6jryNpmoZqb/0nVNPkpptE0fmrk7SfwjmsEi7KVjV9pB6CRILrx+DfdmszdxeWpCJJzRtYVgMlrhHP7LABccZ1ZcpLI3ygo/LGEPMOrGtK4jV/0hHkdxJrRP2my0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059047; c=relaxed/simple;
	bh=v8T0JE9z/ge8d43YeWanAagTAp6GfHEOwNvCGrvqvoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQ0vHPJzhYfL29yJUlpsksTlOmmOXDwI7iLOAEm5bo7nAH9m4ijVHYU+TT/0tDf7wH52/zyXGgeW/kbG9v5YPw1MZ58T+oaXX7BtbWJ40xdEzwOL8cRw1rnxAatnbXMwPv0Ub0StxlB6UMoYV+KBCCjiMLpK9indW9eo8kfOdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I1vbeiKc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v8T0JE9z/ge8d43YeWanAagTAp6GfHEOwNvCGrvqvoQ=; b=I1vbeiKcS2QNkzMf3HXpxVJlb6
	nZe0VAAYTXCcITYw/bsOcaD6r/TovPyo9y/PPxtf29QLiiZoaKXAfIdMzRs34JcC5NuUszpy8TyAw
	b88vx+PWbPUiYo6miseb073mPGXmNwVbtrFv697hjU3jeJgiLUVkWQcXb4SRkFKHMscDSrAi0FVMB
	vvbc7FKPRWkjkzVFA+a4ObVzAROmj+pZfy8fn/ino2a8Ej2nRUkHx08h2gd+mI3o+cjKAFCg3B16D
	0NNz1hs+EsRxdKiJy2FFjnSt1eYJOGj4Lm+bV63RNofq+4Q27QURoV7ZcIpMuTuQ7fQu51CouGxxR
	AuppKydA==;
Received: from [139.47.49.49] (helo=[192.168.1.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1swl5w-004uaU-LB; Fri, 04 Oct 2024 18:23:56 +0200
Message-ID: <20654eb7211b951ad97052ef3b2730e94d3b608d.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Stop the active perfmon before being destroyed
From: "Juan A." =?ISO-8859-1?Q?Su=E1rez?= <jasuarez@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, Maxime Ripard
	 <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	stable@vger.kernel.org
Date: Fri, 04 Oct 2024 18:23:55 +0200
In-Reply-To: <20241004130625.918580-2-mcanal@igalia.com>
References: <20241004130625.918580-2-mcanal@igalia.com>
Autocrypt: addr=jasuarez@igalia.com; prefer-encrypt=mutual;
 keydata=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
 fUePB/i37LpOs4mt4/zIFeWDJxdHzBNHg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Good catch!

Reviewed-by: Juan A. Suarez <jasuarez@igalia.com>



