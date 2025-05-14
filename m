Return-Path: <stable+bounces-144435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394EAB7696
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDAF1BA6619
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6EA295DBC;
	Wed, 14 May 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaySo9o0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CD1F866B
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253653; cv=none; b=YlNgIin2WkpCHHEH7rwYpTEZUWn75hbdAoCU07COOBeYHYXH4KU+XHJGwd+TL85Ulc0pwCliIPmngLOJG/uoV1J02ti2jbybY+4tutQl3Csg34p99ODrQzcf2YV6XPT/E9Ywe4ndjo/ypSDgFcUOVqYqOqirIu33FIzgw9bBW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253653; c=relaxed/simple;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiBgnApL00DS9y5hPcxOlf9yvm9bcFIeC/7RVdrnWBCOHM1N1XZOV0wmtL6YN81En/Qpe7hzFfARS3lceK9Cr6ShptcFbmcKIav6IRbL4tz9jmxCl012Nm822cURWxhXgOb7wJiCbLk2MBT9tLNggoco/4B+t8SYnjL7dLlgNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaySo9o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C052C4CEE3;
	Wed, 14 May 2025 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253653;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaySo9o0ycN67A+eD0gaoSCwwItMzFiY1zZL1xLYrypgLkLguuLT3s0zkl8Yxf13C
	 4Cu091sYSKHt0AgG8Z0PtVYUDKCihU2QddhsjeyeFPNXANZicF4rKgs0psSk6UV3if
	 4PRjmTOZl6cYUrCn2LqWNeBUBnfcgdA0NxLlU6pW72OES6dKuv93LnU5qjCKfy15ZN
	 obJZB8czujV1Ce8O3V+DcW3SAG2Q1AJgq71Hhjki1pYmvvcbt8f/179gVW81FR369O
	 57v0f4ZbY9+SScUJ4Xh/kLSEthDkWtQb+FQJ+mDt5eyYnGfdVVLJx0pepodpzRe+B5
	 44Ljforzhc6Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	changfengnan@bytedance.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] block: fix direct io NOWAIT flag not work
Date: Wed, 14 May 2025 16:14:10 -0400
Message-Id: <20250514090341-9d3c0ac40275ccdb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513112804.18731-1-changfengnan@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

