Return-Path: <stable+bounces-163252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C315AB08BD8
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A57189B1B3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361629ACE4;
	Thu, 17 Jul 2025 11:40:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3305DDAD;
	Thu, 17 Jul 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752459; cv=none; b=aKMn2P/BvQsBRvlbz2i+9DM5HpbeSOSKia3xdRzQDF/lcGfDx+AfJaEn+egsLnSAZrFKcOZB+9FzNVwJL5XnsvAXGavBiI4wxNW/c4S7+9Ebz45Kqqh9u9r1gU1PQ1JR34hn7QLQiC9qQdyNWmy2AhSq0HN36Us/ORqS7j6dkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752459; c=relaxed/simple;
	bh=PyDGedYrP4k8Aszf5hpD4KCimePEOpFHiQOOiG+glm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDcBUH5zgic0fKGTafbmey5PPyQ9Svip2yNRhWABsuK5uHECfv4k56PuYuKl9aZFvcZx4bz1hMVpIOsRKqQ4ev3XoppM0qv3RvAHlpvNFouaUU3L3BnyodBp7xtVPoWbvBOj/HgaQ+mbA0H9lulAfFJi8kLnnkrH2pgHFo/bfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C88CB227A87; Thu, 17 Jul 2025 13:40:42 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:40:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] nvmet: pci-epf: Do not complete commands twice
 if nvmet_req_init() fails
Message-ID: <20250717114042.GA18331@lst.de>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to nvme-6.17.


