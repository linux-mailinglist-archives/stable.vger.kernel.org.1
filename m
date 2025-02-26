Return-Path: <stable+bounces-119644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0CA459BF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ECF1887644
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7B224248;
	Wed, 26 Feb 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nM/BzAFS"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D451E1E09
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561311; cv=none; b=Dp0vdPPIgwZD/4Ah3aIX13dAFq83vn/JwGczG6HAXGIeTZVsTTDxkg9DowikhVOlXjXOs2u3BNxOeoOrBtY0oWXvS+TuAswKyPScx7wAr3LNGNNcTgQXnvu6TWxdYxHpaz4PHGjEBjtgvDK/egBu+PcoXbpit2dtqbaKIDsHXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561311; c=relaxed/simple;
	bh=vic3C4G2VltFJW7Hmi+B1ArKtSxiWC9lcVyTfiY7oT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzv2LbwtLuiu0DO+DaSeYoPXBtY8FIqqTjuN0Gz/n9AbNMKbXN4YJaoNrRO92YUDpdUhx061fbxE6p2OeiirCSZ/r6pWhqp5MS9NCvLlyV9Bg2bP+pYjfaJSkXlFMPqWMcS/WbKW/Ydh6mj6hqQzCJFyqZKANwSAQMc2DuHePR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nM/BzAFS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vic3C4G2VltFJW7Hmi+B1ArKtSxiWC9lcVyTfiY7oT4=; b=nM/BzAFS7xWTF8+G8vN6kytYcp
	igGgMthctSf7beauboh2VJpyvcJCartU9Hljz373FQDrw2PVPnsmgepmlC9SZr8bFmDM+Ifp1lm0N
	XDt5geew2LZ7jiaQpm1sKyZnZuZq5vwV6aHlWpx9KuTiUe7bGA8TNeiDSxmg40ZYnO4tnT1MKpCtP
	N59H5Fstv7ZTTfod87ROjliyCPgJ/XicwX25tUeaTHhvl52nj5z8focNL+laKpdy8sT9i6QqTcJY7
	1HqdbG9zw2da3ad7huejGaIkxh4yS3asHJfbaHQge7JZUEDVv4TQKHmxxor+t7masQNFGT5TwFh+B
	KVjE8aGg==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnDVM-000s2D-4W; Wed, 26 Feb 2025 10:15:06 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v2 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20250225105824-0afc6ed16b83d039@stable.kernel.org>
References: <20250225105824-0afc6ed16b83d039@stable.kernel.org>
Date: Wed, 26 Feb 2025 10:15:05 +0100
Message-ID: <875xkxysme.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Tue, Feb 25 2025 at 11:13:43, Sasha Levin <sashal@kernel.org> wrote:
> Found fixes commits:
> 55e802468e1d sfc: Don't invoke xdp_do_flush() from netpoll.
> 157f29152b61 netkit: Assign missing bpf_net_context
> fecef4cd42c6 tun: Assign missing bpf_net_context.

The first two affect other interfaces/paths unrelated to the issue
addressed by the series, I think they're functionally independent so I
don't think it's necessary to consider them for this backport.

The third one is patch 2/2 of this series.

Cheers,
Ricardo

