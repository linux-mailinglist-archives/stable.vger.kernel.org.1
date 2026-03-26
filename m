Return-Path: <stable+bounces-230524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N2YCGaMxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:43:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3333B0EE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCCD3306A387
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F1379973;
	Thu, 26 Mar 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rT+EojIP"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D33A5E94;
	Thu, 26 Mar 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554086; cv=none; b=oid/WEa0g9PeiEop1Sf7sX7xiFXeLYuMp8Yl1Bh12OeUlgOzVukcYWdydRs7O/MiIUJniE7LCbxws/8zz6aXCwoqAnASG5jSqP+AsLCnVi3v1lUGLP8NJzX25LMRDFfS3wQCtezVCeUlQAiNHIv3fMnDZXSj/q6/H5Y48tcgptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554086; c=relaxed/simple;
	bh=O8NRFSNU+/6rEfw6MGH3K4BZDcFQq11xwpcIzFERqno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXgUGYNCNIGX5FOqt5/9Ft5rrxbdV850I3XwT9AfronBlEVVaVysIH8Gc1VnJxdS7nEOXxzvl6bmpnl8PFKZcoPjrB8u3Y44Ic8BRdYSQgL8COKPqzN+3cHaLSFlgiGhr3g1/j4oLYnUqY1QpyVM8NCEdWyivHKgyRRvLWSj8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rT+EojIP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Dpb9g4AmMThBft7vkg8e6vXf6FuktuEf/tpfSoteEvU=; b=rT+EojIPKSXnKnUMTD+m1OTPSH
	A7I54JD6N8ZUJ6yk6wFwyNmv64ay6SzS5sYxnTBtXLbhN4nwxZybp2Ihq1MdT/ysS7UH7QMk3DDJI
	bsbVgBuavW9jusYW+Endx4CtvyE/gyRJ7c9RGLxqlHrYkNcFS20QWWoXOIv3HcD9hMxgZ1LmNFeEF
	ixWoEWh1ig/YSnfufxCqRIvYWG8YTGjlqfIRheOYMG48fIsUF33AUviOfWxOUIeBBfGxUbDXgm3GN
	xF5QZBVtvga3vddP3IHZkPvZMKaWl6KaPTXd/du74CUcWLBqASct75RH++pcJeMC8yesjgCZEkJdN
	dEgjoIig==;
From: Heiko Stuebner <heiko@sntech.de>
To: dsimic@manjaro.org,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	airlied@gmail.com,
	andy.yan@rock-chips.com,
	damon.ding@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/rockchip: analogix_dp: Add missing error check for platform_get_resource()
Date: Thu, 26 Mar 2026 20:41:02 +0100
Message-ID: <177455405025.1277100.9154937580491920768.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209033123.1089370-1-nichen@iscas.ac.cn>
References: <20260209033123.1089370-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230524-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sntech.de,gmail.com,rock-chips.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,linux.intel.com,kernel.org,ffwll.ch,suse.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:dkim,sntech.de:email,sntech.de:mid]
X-Rspamd-Queue-Id: BCA3333B0EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 09 Feb 2026 11:31:23 +0800, Chen Ni wrote:
> Add missing error check for platform_get_resource() return value to
> prevent NULL pointer dereference when memory resource is not available.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: analogix_dp: Add missing error check for platform_get_resource()
      commit: 45895f4d4d5f222d07412f90664f88b059627859

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

