Return-Path: <stable+bounces-125957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F3A6E278
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E817058C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353F264F9C;
	Mon, 24 Mar 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1ndWjuC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09F26136E;
	Mon, 24 Mar 2025 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841294; cv=none; b=eT9qutuFfltrTkCOEiAD3fZod6C7vFJoGN6BQ9Qbq/XK/toXgc6byUqb/a1+NQLZ21reHrYmXnWrAB6Xay4WBgD1xQ8odgjmihXZxtUq5j2JjkpTmj2rFhtxnLwSxnrjIg73DL9IUr85hv8DTddpeGvWQMIAU14gEd5YxtOQLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841294; c=relaxed/simple;
	bh=y0BX7r8ryEWjMxOOO9xrdurEHkOyQxtBaLfq3+2msBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye8WxbRUsLL+cLokncJrgwgM6WA0QWITeYGIj8E1FKZNkbgIU/5OzRSzMZ0sA0SavqIaqN+KD3zeJI/fyusEmWwNibjO3Heq752JbUxm5EMT6xFA5iWd1f488noSuZCjzp/LDOtqVRQkwlD5gGhguPvnAi5XgffDShrTOu5Kh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1ndWjuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E7DC4CEDD;
	Mon, 24 Mar 2025 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742841292;
	bh=y0BX7r8ryEWjMxOOO9xrdurEHkOyQxtBaLfq3+2msBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C1ndWjuCBM1XTyGk+PbUv3bAeqUBsI3f24qAxf75F3b2S0gBLd/gxLK1M8CTwycGR
	 EGEq+rV4FcPUlMjmWU4JOpNtB3XdC+BC5Jqn9AAWoZ5lDVqq8C96oFOiv6LAfclzM5
	 Z2EopyxqpZmamZ0gLvM6yuMsAzi8tCP7HkvlvRs9ytQICu82Vq+ySL3Sd7/Xzemijt
	 qMHfgbc0K18Rxf7iYK4nD0HtFXlIfQcqfY4OUCdg3e006ueekYleJb46lZO21O9bY0
	 Kv7yZS3Qa03m826wLjqxcA2B7ONVeKA16uJ7ok2OJ6CqFsdByI733foISPHls3XQqG
	 Sj0nP2/SznzyQ==
Date: Mon, 24 Mar 2025 11:34:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: Fix accessing freed irq
 affinity_hint
Message-ID: <20250324113443.215c036f@kernel.org>
In-Reply-To: <20250318032424.112067-1-dqfext@gmail.com>
References: <20250318032424.112067-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 11:24:23 +0800 Qingfang Deng wrote:
> -		cpumask_clear(&cpu_mask);
> -		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
> -		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
> +		irq_set_affinity_hint(priv->rx_irq[i],
> +				      cpumask_of(i % num_online_cpus()));

This does fix the bug you're targeting, but FWIW num_online_cpus() 
is not great in general. The online CPU mask can be sparse.
You may want to look into finding 'nth' online CPU instead of the naive
modulo as a follow up.

