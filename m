Return-Path: <stable+bounces-230525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNjLMo6MxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:44:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492EE33B115
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0827F3082D88
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107A34753C;
	Thu, 26 Mar 2026 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LH8F33gG"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F03A6B7B
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554089; cv=none; b=bEyZ1ELW5c+biJHkvLxGo5R6uW406QrYjDGgr5OoOD9zm+bQIl4IwRuT6umv4q4hRLiELSAIzQSHvF+lm6iMUHRFOGQGy6N4wuS8HOBMmNZjExCpiWDUWnu1qzJZV9WHy0Jcqj1hcdKjQZ7SyWa5kD9AbTn4S7RbUEE0hM9yXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554089; c=relaxed/simple;
	bh=8lN7FXngLeu6rCVId+LuYVu2MRQjz5tYzO5EbkvX7x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfqDhiOEuda+92fo9lydOXpFUBD6oqzY90QjtQzUlUjn0DW3/rGad08wyCmP48lmA+8LHmR7OoeHUhVlhkCvW2eqVU8iAHJzsoLnQZ03UGVo5ok1DR7XoZRa6GAUavcoXdRtz4/GJLjFj4h7eolnj4qx5S6wtOqjnORsQps/Pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LH8F33gG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=UqTxQ4+4Pepmm+b7jcLTYHrn6v3kt/yLegb5GQyalhs=; b=LH8F33gGysSTYfISC7040NDRaD
	DsLmNS1xma9eh6z+mEvhsnZUTmXRnynwKegM5QzVVxZq8Ss75LiexyIC7Z3S3SH9imRTftaDHfm/2
	LcxircO6NNZ7pjq/na0O/42/KFwgedsC93YYts7AbtX2gTNE33RyY94x89hkMS9RBHSrh4hmJNrAb
	Gj9w/BbAFUmL+PVjDUQaT5m3eS20BqWF7085khKiY6KhOG9TkeRYEpJrg9uTv1zKqGD3imK0+492c
	st1y+9uWqr5wZWApsARXySbB0SxxiY04zmsl+62vohNDC4aRJ4tZRW3FFKMmJdd8Up/df6VIfO4nG
	Ny4iJquA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
Date: Thu, 26 Mar 2026 20:41:03 +0100
Message-ID: <177455405026.1277100.9686566905955604923.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
References: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
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
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[rock-chips.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,lists.infradead.org,auroraos.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230525-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:dkim,sntech.de:email,sntech.de:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 492EE33B115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 30 Jan 2026 23:35:42 +0300, Sergey Shtylyov wrote:
> The result of cdn_dp_reg_write() is checked everywhere (with the error
> being logged by the callers) except one place in cdn_dp_config_video().
> Add the missing result check, bailing out early on error...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: add missing check in cdn_dp_config_video()
      commit: 46c31e1604d121221167cb09380de8c7d53290b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

