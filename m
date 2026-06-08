Return-Path: <stable+bounces-262042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yWVzGhPMJmrfkgIAu9opvQ
	(envelope-from <stable+bounces-262042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 16:05:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B200E656E9F
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 16:05:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=mSUBhBoh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262042-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262042-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3AA53091F08
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914773C819C;
	Mon,  8 Jun 2026 13:57:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86393C3456;
	Mon,  8 Jun 2026 13:57:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927055; cv=none; b=DOYV2sSr9AppTaW9qqyisP0+HjFQLnAIh98KdPtP6Ix5u0BkgePjwsh8Ccy2MMBr7b9Eq7QJNg1+0biajafjlFvk2skZsQoy6xB0PMTzj/oBdxz1NRHHBTXAec5cvUSNESM4ja2EUZnDFNlhub4S71jK2Klv5R1TcF2UWQHh7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927055; c=relaxed/simple;
	bh=PUAzZqFOE1r8m01APLHVgv/zFAIdkEgJl07BOOwnD+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NE1dS0fquMwhBSwobLx6cT2c7BQmBfomFezceq9HBUgazgG+JPxPqsrgL1EYAKRZW5MHTmphMIfb2GIe1wWfZQehQANzpLp1piP2U4rwosk6/q+sq17xic2EEFUn0pRsLzCDAC2W5UsUscHEm2BTPwdIUI7bOr9HZqtJtj+b7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mSUBhBoh; arc=none smtp.client-ip=45.254.49.198
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 418697a0a;
	Mon, 8 Jun 2026 21:52:17 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ttabi@nvidia.com
Cc: dakr@kernel.org,
	dawei.feng@seu.edu.cn,
	dri-devel@lists.freedesktop.org,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	namcao@linutronix.de,
	nouveau@lists.freedesktop.org,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Mon,  8 Jun 2026 21:52:18 +0800
Message-Id: <20260608135218.3413471-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
References: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ea7816a8a03a2kunm10e519bdf5324
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk5JVhpJS0lPGkkaT0NDTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=mSUBhBoh0496xG4IiMYv5fe7It4OxD9eTPVOkNlmdB4vm520ELI4bYLj9R/YziGnOA7drsT3LqfYmPOjmRkbMJhKYoGBKqtDLXlWUPp9ktE+vZsjFQRIgsJGS79ZnfDIAxg2lMUGCv3s3wkryPG5OOUZJvv/6CxUIZjLG0kTwuI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PUAzZqFOE1r8m01APLHVgv/zFAIdkEgJl07BOOwnD+Q=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262042-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ttabi@nvidia.com,m:dakr@kernel.org,m:dawei.feng@seu.edu.cn,m:dri-devel@lists.freedesktop.org,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:namcao@linutronix.de,m:nouveau@lists.freedesktop.org,m:simona@ffwll.ch,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B200E656E9F

Hi Timur,

On Fri, Jun 05, 2026 at 06:22:41PM +0000, Timur Tabi wrote:
> I think it would be cleaner to instead delete this
> nvkm_firmware_put(blob) call here, and just rely on the call to
> nvkm_firmware_put() at the end of nvkm_falcon_fw_ctor_hs(). Then you
> won't need "blob = NULL".

Thanks for your review.

I don't think we can drop the nvkm_firmware_put(blob) here. At this
point, blob still points to the image firmware loaded at the beginning of
nvkm_falcon_fw_ctor_hs(). The later nvkm_firmware_load_name(..., &blob)
call overwrites blob with the bootloader firmware pointer on success.

If we only rely on the final nvkm_firmware_put(blob), the success path
would release the bootloader firmware, but the original image firmware
pointer would be lost and leaked.

Best regards,
Dawei

