Return-Path: <stable+bounces-144052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F48AB46C3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9657519E71D8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECC299AAA;
	Mon, 12 May 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw64p0x4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC9299AA5
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086743; cv=none; b=CZsY1KdgajQNiZrY9+Wc9ULFVPzPQbhbktQz82/X3eJbetdwYv6O7e4UmKdi9h5zWuD892rGQEFfPkDqs8R3lNIajLTXSnLb6xjEi/CMi5X8yH8OE6Fv1Frp7lPGHMdMxbxv+YZL+OOYlIRRYm30zIFh87wJvsPuPwsXALCZD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086743; c=relaxed/simple;
	bh=cURNEQd34+Q+vC49/pZVX0Vp1yuMGHVs63XxFivOpLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyTrw18Bc2CNYpv80ago9rXq1XnJuUiDsXxlNiDGZ9olWikiwND2sZH6fN1SlFlrPy6XOIYZreuMYg6bA+/m/lyZeBqwTec3c4i8xYeErXKNqBW/ygZ3xnJ4Jzll2+5lEjWQ/asOo5HhckrQJtzWJX3H8qXss9PaH/zIj1jc+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw64p0x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC1C4CEED;
	Mon, 12 May 2025 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086743;
	bh=cURNEQd34+Q+vC49/pZVX0Vp1yuMGHVs63XxFivOpLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iw64p0x46W8/DnD3JVh9kp9zzz4kYkJDWIV4hIBlTIts16L3cEfRhm6BqKnuIxLnv
	 K64FQawYr1OR6D/pi7rVDLJfKmHHtmRK9H4suSOaf/EpQDh038pRf8t+Gb4G7HZREN
	 mqJhRtuTae/DXX3ShcPkLED/J6y0/kyvYZE0/OWkQd28Sr/DJlWeTEae66t/PN1wUa
	 uEEYxR18l3IG3bw9jrsT0kgvzCOhku59NlDZKwevcmOqJqGGDx0sTrkWf3e5f2+P89
	 LmO3gcj+Hy+cvvCAZYSffyAuyc3HTgW9+hBuOJQuMWye5BS2o29Ks4iwwkb8s6rAB+
	 oxJmpKsviV6ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	echaudro@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] openvswitch: Fix unsafe attribute parsing in output_userspace()
Date: Mon, 12 May 2025 17:52:19 -0400
Message-Id: <20250512171051-d0977a979bf65698@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <b047b86872e58e15c3b8d3ba394fa1aef4b557ea.1747039582.git.echaudro@redhat.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 6beb6835c1fbb3f676aebb51a5fee6b77fed9308

Status in newer kernel trees:
6.14.y | Present (different SHA1: 4d184c1b89b8)
6.12.y | Present (different SHA1: 4ae0a4524c47)
6.6.y | Present (different SHA1: 46e070d3714b)
6.1.y | Present (different SHA1: 68544f9fe709)
5.15.y | Present (different SHA1: 99deb2bf2bd1)
5.10.y | Present (different SHA1: c081a8228222)

Note: The patch differs from the upstream commit:
---
1:  6beb6835c1fbb ! 1:  88825867905fa openvswitch: Fix unsafe attribute parsing in output_userspace()
    @@ Commit message
         Acked-by: Aaron Conole <aconole@redhat.com>
         Link: https://patch.msgid.link/0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 6beb6835c1fbb3f676aebb51a5fee6b77fed9308)
     
      ## net/openvswitch/actions.c ##
     @@ net/openvswitch/actions.c: static int output_userspace(struct datapath *dp, struct sk_buff *skb,
    @@ net/openvswitch/actions.c: static int output_userspace(struct datapath *dp, stru
      	upcall.mru = OVS_CB(skb)->mru;
      
     -	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
    --	     a = nla_next(a, &rem)) {
    +-		 a = nla_next(a, &rem)) {
     +	nla_for_each_nested(a, attr, rem) {
      		switch (nla_type(a)) {
      		case OVS_USERSPACE_ATTR_USERDATA:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

