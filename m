Return-Path: <stable+bounces-195271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD7C74054
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AA2AF2A8ED
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF52C21C1;
	Thu, 20 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfNKBWeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266932E03F1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642635; cv=none; b=IWCWlsCHfsyVRz/dp1uTGGVfyIfDTto70ElKCHj85eP9wqBwjRXrwZ16w8Yo+yl9Ch0ArzkF1gktsz2qqgPzzNxZQP7+9D7vnX5Cp3QsqG8NYlJizaACBD8TfYZ9/85MjKIyEqs+4TBEgII6CHF9T2EzrRbAPZgiU/evisIUJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642635; c=relaxed/simple;
	bh=wALybBOwfgc/XWEOQ5iWGvl57ismMJnraUsi+1nzINA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2FohY3n17++kPt9AM+/5su/w4Nx2dQalNLcmllvCihWcJAK7bToB40WjQGzIIZwPYcCzJzEIw9Fz0wwaDRx75tyLaxHPzsk2tr9aNbu9ecvSRjASnhhXyiVhQ3ELGf4ZMnA24IWQecvoVfFbgkMY4hLMhFcG7odwFg2ca4cA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfNKBWeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E299C4CEF1;
	Thu, 20 Nov 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763642634;
	bh=wALybBOwfgc/XWEOQ5iWGvl57ismMJnraUsi+1nzINA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfNKBWeX1Psgh9t9vmxpW2UtJ5Gm2MWbDPh1VRksXP4FHRiq1rfKGM1UyJHLZKnOT
	 CMAAP95XVEjn5ScybzjorQE2L/RKeYr4eZxvIgt7MHWRX9cMt2qI9SIKUfYcpketlW
	 HCy2nXcmYPLOpZOmkXsh9MPr7ggFflPiqMGBJZT6Zq2Es9K8QfHtpibJOEP1aFP87F
	 aueu3tYpwvfJN2GU7lpkVS+e0YmyEt1D07TMs1JXW/JJa0/cNeh/lxx7Q8C4gKr81h
	 qTJv+qowNUCuNcpVHexboqHMvlDovCmtknoVxsI/iyDmdGHoph6frQfGDRX4tSgUg3
	 ZW0hewvsPz0gg==
From: Sasha Levin <sashal@kernel.org>
To: Chen Yu <xnguchen@sina.cn>
Cc: vladimir.oltean@nxp.com,
	horms@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Thu, 20 Nov 2025 07:43:52 -0500
Message-ID: <20251120124352.1816256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120061231.3103-1-xnguchen@sina.cn>
References: <20251120061231.3103-1-xnguchen@sina.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.12 stable tree.

Subject: net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Queue: 6.12

Thanks for the backport!

