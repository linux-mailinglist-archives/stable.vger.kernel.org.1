Return-Path: <stable+bounces-254671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOT4GuxKF2qaAAgAu9opvQ
	(envelope-from <stable+bounces-254671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E65E9ABB
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E989E305BB18
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B553B27EC;
	Wed, 27 May 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvCqghQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2503B27E1;
	Wed, 27 May 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911368; cv=none; b=DJ6EY1hSGrF6P4OmY9CzpO/bRPYEn5ySOtiRYFQS1tV2cJW61tjdPAF8cN841BGg2XH94l1Trjr9kRi2E+WuOBGBdkTLsxPdmmRWlaZYyh+d5X0LKsngmHtyXgHeLjEacLvjFlMcg0mfmuP4aqMyG5n7cIJaxTBcNvZq006G0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911368; c=relaxed/simple;
	bh=v89s4B1mqSIf7j//EsoDnuERwexrjSyciuIsRlFS/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skEI72SaELWSPYCI+NPEh5JjlioDNPXYvRH0XtuiX9aQ7RdwgnsYC1dlmHqvEpujNGtejzH/tLiUpfCR+53zHhbKcb6t9sYxm40uKZqqSiWJo3R//Q+vXeJMYZq2QSWuACixfuyW0sI8Bx3NqMohk71sGi3uCNlwmJbXpHSsGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvCqghQM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF41F00A3F;
	Wed, 27 May 2026 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911367;
	bh=v89s4B1mqSIf7j//EsoDnuERwexrjSyciuIsRlFS/xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvCqghQMHRVW2hLo8U7oG35uTKb7pGf4HgMYFO4CLfyRpONvk8kegNlXUxt8vxK12
	 lz8RXyXppTdz4AQrFfntCJ9e0f0RbPKFbZWX2chntIyF4NbNys4Yak3p9FHbagjXKl
	 K06cPAoGerUTHfN2L54VPAeIiEtVPkIjv11wAtG/neAih4tWf7aIxvb/iaIWtOkXNl
	 qAYE7nyRULs0oXPdTF6QE6uAJ+6V2Yj/34eA14lJlTGaRxrb21s6oyOE1gPj7PgA5G
	 aA/9/+5tWiLZwvVHqD+Bg6vr0xWfNZ7coI3xxydnp79Wga7JVj0+Q7n8jw7NGSQbQ2
	 Cpo+IIcwojNmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	jianbol@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
Date: Wed, 27 May 2026 15:49:03 -0400
Message-ID: <20260527-agent5-item011-mlx5e-ip6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192214.78312-1-gyokhan@amazon.de>
References: <20260526192214.78312-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254671-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B8E65E9ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit e35d7da8dd9e55b37c3e8ab548f6793af0c2ab49 upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

