Return-Path: <stable+bounces-223436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA49A/2QrGldqwEAu9opvQ
	(envelope-from <stable+bounces-223436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 21:56:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCA22D99B
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 21:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24C2301A712
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87C346AE6;
	Sat,  7 Mar 2026 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=valentine.burley@collabora.com header.b="hBVBPo9s"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3F35972
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916986; cv=pass; b=giESt0vq+HP9BzT4WDLHGs23CEJhen7fFtZi5CdSVgl+2Okyw9kumZdpGBWTIgXgtDcx5ZX9A3gRFoheHkOI3XhhA6PiMEWA+koEs9XijiVil9C4Z2zShWP6xJGf8R/JL27sQjww/nJMC1kfoXrZYnpbdTtSJo5gGrras44k2nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916986; c=relaxed/simple;
	bh=jOZ+jKk06ymUWiJCgFM+BEuPeNV6eQ5aTfrKOBw/OOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KkkOaOPySqctgfthbyjuuMgB4Qp4VJBmdmz++Z1URgQ9n9LpiN9/ikNEFXuDVvAGcf4LyDTBOUUE25E65LGmNH8hNMCLBTPOIAOQslsLyOQXmfTd5r3khZjt11G7p9qRemeLWuIk4efBC8mGqJZctEVmHm0gpR2C9X/Cwy88D+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=valentine.burley@collabora.com header.b=hBVBPo9s; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772916973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IY/JOUjU0BSbHYgyUE2n1iSklSZ3vUVHq/1oA0/9b1oQK7eWx4IPIxsCHBJhp9fCW1orHgLy526Yfq4eru1++JGqP3wzDYqYqHjHtkW2VsP346TiZPIZf5LVnPYxJcIwT8Y5YcU6DRiuYhjSDMJWAjVtKezhhk1L2pG8RqFE5IM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772916973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5zBkG3bRWjfaR2r6dkEHen401YtUYDgTYZk5g8WjyLg=; 
	b=ltu7QXqkbCS6apVNzObPC3bbKgIhihcP0QfESvRyaQlj4TOAgqXwcEXmjHvCAvqBH9+NHVDbdqboS7uhcdIc0xRNuJPUCewBOPJaiZij9LQISCKCkIVtCt+YE21W1TThvMPKwrGSgxtiuruVQShecpYK3Q7TnIH01QLOa23e8gA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=valentine.burley@collabora.com;
	dmarc=pass header.from=<valentine.burley@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772916973;
	s=zohomail; d=collabora.com; i=valentine.burley@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5zBkG3bRWjfaR2r6dkEHen401YtUYDgTYZk5g8WjyLg=;
	b=hBVBPo9s5YJbTw2rBZA4HkfnRcaVB3KV8+Wa21ppW/bzc6bs1gATHfGIDDPGGv1M
	IfoS5Q44csFDMkiYbz3DUe561Heuq/Qgi3EYrj2+iKxMx4vOUVbg/jVbISfnxo+pYJk
	kRhnWDZTJUdNKh4XxZhRDez6we5/Gz53ZYZ8Y03I=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1772916971944637.5840052500968; Sat, 7 Mar 2026 12:56:11 -0800 (PST)
Date: Sat, 07 Mar 2026 21:56:11 +0100
From: Valentine Burley <valentine.burley@collabora.com>
To: "Marc Zyngier" <maz@kernel.org>
Cc: "kvmarm" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
	"Joey Gouly" <joey.gouly@arm.com>,
	"Suzuki K Poulose" <suzuki.poulose@arm.com>,
	"Oliver Upton" <oupton@kernel.org>,
	"Zenghui Yu" <yuzenghui@huawei.com>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19cca161997.6f32ad1e5004303.2690428975656613167@collabora.com>
In-Reply-To: <20260307191151.3781182-1-maz@kernel.org>
References: <20260307191151.3781182-1-maz@kernel.org>
Subject: Re:[PATCH] KVM: arm64: vgic: Pick EOIcount deactivations from
 AP-list tail
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Queue-Id: 5FFCA22D99B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223436-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[valentine.burley@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 07 Mar 2026 20:11:51 +0100  Marc Zyngier <maz@kernel.org> wrote
 > Valentine reports that their guests fail to boot correctly, losing
 > interrupts, and indicates that the wrong interrupt gets deactivated.
 > 
 > What happens here is that if the maintenance interrupt is slow enough
 > to kick us out of the guest, extra interrupts can be activated from
 > the LRs. We then exit and proceed to handle EOIcount deactivations,
 > picking active interrupts from the AP list. But we start from the
 > top of the list, potentially deactivating interrupts that were in
 > the LRs, while EOIcount only denotes deactivation of interrupts that
 > are not present in an LR.
 > 
 > Solve this by tracking the last interrupt that made it in the LRs,
 > and start the EOIcount deactivation walk *after* that interrupt.
 > Since this only makes sense while the vcpu is loaded, stash this
 > in the per-CPU host state.
 > 
 > Huge thanks to Valentine for doing all the detective work and
 > providing an initial patch.
 > 
 > Fixes: 3cfd59f81e0f3 ("KVM: arm64: GICv3: Handle LR overflow when EOImode==0")
 > Fixes: 281c6c06e2a7b ("KVM: arm64: GICv2: Handle LR overflow when EOImode==0")
 > Reported-by: Valentine Burley <valentine.burley@collabora.com>
 > Signed-off-by: Marc Zyngier <maz@kernel.org>
 > Link: https://lore.kernel.org/r/20260307115955.369455-1-valentine.burley@collabora.com
 > Cc: stable@vger.kernel.org

Tested-by: Valentine Burley <valentine.burley@collabora.com>

Thanks a lot again for the quick fix!

Cheers,
Valentine

