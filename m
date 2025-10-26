Return-Path: <stable+bounces-189894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C2C0B6E9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 00:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDD4189F772
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE92FFF95;
	Sun, 26 Oct 2025 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPJDCQYR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8B2417C2
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520583; cv=none; b=PltUWPZzVotFcLU7xt8A/x6aEGj7kTQjZK56OjCbkIrNwrw2nvXpJXHDJVC/rRFHf5W7Aov36tdz+xir3YlgqdomG8guo3ZrrdbouL28JBaPD2chnhqFyn6zCdwXqF9enjJmrtnpfzS4Tgd05jqLJmEr8A90KeCeJpHqy7+57po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520583; c=relaxed/simple;
	bh=KQ6oL4hiz75C/A8/vFj2v/R+XXo7kpXKDEDVyBnk9ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxm+QJY6n4bqlOGD975htm6cy0B2X8KagdvlVgBzu96o/XT09PrDI5e5G01hylQLUokiS4rz28Y+qyjV70DRcYI0J0ZJs++GANuCDFDUJCCiBaj5tfZxNLos5W371BbDyQtnphwzJA9emMitr0n0zWMHQl+m4qtjR0KzjcqKC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPJDCQYR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761520580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TM9g2J61qUgy8rn11tUgr2Kr+gynrxk9ajK18D17/SY=;
	b=RPJDCQYRhVLFsadMNhgBG19pz3iarfNc8xA24kPqVsz/1YivTlvNktdaKCQ9kaIOcLUxXM
	pCRsFOPGobAH6gKDiNfJSsJEkHxiKLSO3YYgGLBqyuydxaeMSmP/R5WNguJ5yYYrxc2k39
	qHYjdrBoNgur430TBoSwBdqDK4cq4uw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Kd_LMUUGOBeUGGIC9bJTaw-1; Sun, 26 Oct 2025 19:16:19 -0400
X-MC-Unique: Kd_LMUUGOBeUGGIC9bJTaw-1
X-Mimecast-MFC-AGG-ID: Kd_LMUUGOBeUGGIC9bJTaw_1761520579
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8a2594fa114so256970685a.0
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520579; x=1762125379;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM9g2J61qUgy8rn11tUgr2Kr+gynrxk9ajK18D17/SY=;
        b=j/InOn1xKs3HjxFLBy0wx0lMzQAUAYcciUWUd8iwA9sE7bKTIRowMPy7qd4nrjXBiO
         4zR3F9GTKotmWkTZ2XPdxROxhZVUiuORwiRsQHn3623OQ8mW37NdJ6TF7CBXZdm+t8aI
         hxAzWnZMv/cThYNMuh6sDEmVz+UQr4xfo7uyvWyUUs1FjkdGXXADSJAh6gI+jQgKcX1U
         MWjnksHOHOdAU53hkVEZX58umIF3VxQcvB0b0F+QRYr1faDHLwHdBEX9fBlJuWjqz5tA
         WsRCW9iXZmSDEJmqIRNFuvXBRXyqUJeHZXeiTX3QDstCYGPXQiRfGhPURVXl/KmCJVru
         6+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXelssXfxnzRDszgZPqnih5wYZZQ2IJrEJCAmsmZqaPXL7zki1EeRm05WrCmume2+jI/jEaLP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDPFQql8t39Lyedphq5o5Uttzt4skq0QTjTGmOvaV9dKpb64F
	1q8OpNjRSKvFQvJosFsbdMllqywbi6UWwKmCeG6pT9onO2pca9Lr1iGfTEvfmbex5iKDsE9eEjR
	lSKgfUh+HAVv87yJkT2RleXlyHREbcmGVjas3dx396c7t1dqlcWfGVWIuvQ==
X-Gm-Gg: ASbGncu3ka3gYVRTpIXPfYCCN2/xzUV0HEw8hUVqpq+ugVH8EDNc5eKxjdUB9zcfjOB
	7YlbpsNbDxtrFTV8nZxLSgVU8z78F07N2S9jXe5QkGbsW8SmUw/GQy0KyFkzZuiG6QBo48l/SO5
	dkTHZbxxH2+5SW12iR5hv2JPOi5Vaa5f4mLPrG5L3qAG799wqG+W6jpfAhG2OTfuZAIhCQLUW+Z
	cWckVADB7Uao399Xc1m/lpRZuFJ0Pkgrvp6Xrz5Ge+Dkoc58yHEo+ifOfyTkb+h3ZZ8cvJf0q0O
	xnFWbNFUyFoCRsjTtwaHlrT19YF24p2oyicWCcFFgCsCYjNROR37A7wwK1sBg/WGBgP/GEECStU
	sYiVLg7DyhaQ+BYjKSOusPfT1WeYb
X-Received: by 2002:a05:620a:4454:b0:809:b21:5421 with SMTP id af79cd13be357-89da1bae914mr1370443685a.39.1761520578743;
        Sun, 26 Oct 2025 16:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0exW7QsnW96XJU3LfmVTRq5OXRYKfDNXF9pTY84ykGNprSECOl2LKm846J2PimjM64qIFow==
X-Received: by 2002:a05:620a:4454:b0:809:b21:5421 with SMTP id af79cd13be357-89da1bae914mr1370441885a.39.1761520578329;
        Sun, 26 Oct 2025 16:16:18 -0700 (PDT)
Received: from redhat.com ([2600:382:7702:71bf:259:17c7:d468:3f55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc6fsm435746185a.9.2025.10.26.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:16:17 -0700 (PDT)
Date: Sun, 26 Oct 2025 19:16:13 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	mturquette@baylibre.com, sboyd@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] clk: scmi: migrate round_rate() to
 determine_rate()
Message-ID: <aP6rvQD-bwSkhfU5@redhat.com>
References: <20251026144958.26750-1-sashal@kernel.org>
 <20251026144958.26750-39-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026144958.26750-39-sashal@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Sasha,

On Sun, Oct 26, 2025 at 10:49:17AM -0400, Sasha Levin wrote:
> From: Brian Masney <bmasney@redhat.com>
> 
> [ Upstream commit 80cb2b6edd8368f7e1e8bf2f66aabf57aa7de4b7 ]
> 
> This driver implements both the determine_rate() and round_rate() clk
> ops, and the round_rate() clk ops is deprecated. When both are defined,
> clk_core_determine_round_nolock() from the clk core will only use the
> determine_rate() clk ops.
> 
> The existing scmi_clk_determine_rate() is a noop implementation that
> lets the firmware round the rate as appropriate. Drop the existing
> determine_rate implementation and convert the existing round_rate()
> implementation over to determine_rate().
> 
> scmi_clk_determine_rate() was added recently when the clock parent
> support was added, so it's not expected that this change will regress
> anything.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Tested-by: Peng Fan <peng.fan@nxp.com> #i.MX95-19x19-EVK
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this commit from all stable backports.

Thanks,

Brian


