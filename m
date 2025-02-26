Return-Path: <stable+bounces-119646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EFCA459CB
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EB616707E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240A226CF4;
	Wed, 26 Feb 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z+a0qJfL"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8E1E1DFA
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561436; cv=none; b=a7eG1CNRY/JdsL5DXhuP2lAEZpnUZFQ0ZLtkI9hCsiTbPQMY+aRZbCEPJDIubYAwcq5BvIjlJ5XKlhkUGjJbOji3zf/qPX01JB0moyhgjLj+FU/RHBTu89TM9NbMESFjaWvP+scMVn0cbc1IACrcPCXDvLOf6UeE2VLV3IjDBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561436; c=relaxed/simple;
	bh=K8trgH+bKZ3J0FPxvu/QhYIqzG/Cc5AlaY+HesaHsp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dc5amfr58vFwJGYU887kp1IwxJxIz4WDop218CXD4Xtu1F4QwmwY6TRepYf5mlhqKSe1QLTk+Rp/YKr4zsuRC4aIrYxcOIXNbOnf7l6GOgZErbXjYXvhuREp0XkExfqbXEVPGII2en6sA9j+9bemm949ur0tuxjr/Kryn5bTY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z+a0qJfL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K8trgH+bKZ3J0FPxvu/QhYIqzG/Cc5AlaY+HesaHsp4=; b=Z+a0qJfLavDXvH6GvnPs7uDpOV
	9aW1nSALVh09X7/Sa+dJItWLg1DIAQ/8Ek/TAYHdjuhDczc/vwNMs2IHt68YsotKHGhB2zS+ZkdTi
	r4Cy9BwJ97bYrgzBF9pF9ctv1JdlXDBzKzA1g21BOs0xBsJSWnbYoEEGofd+5Kbnm719aOzA2bWFo
	NSk51AGFSIik7MoaSA46RQLHvo1wFFs7bNPt3VuASK/EeZ7tho3NMoWOB01uDb4Q0mzEHrS5wVsUh
	PZ6uU4G24YxkkRHUg3Mj/09bV2oleu1t2Oa+cgEjtfxOz5UIPMO1mOl8pNDVplhQ9ctkTcLGYZPNM
	wVs5GdZw==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnDXO-000s6f-Cs; Wed, 26 Feb 2025 10:17:12 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v2 2/2] tun: Assign missing bpf_net_context.
In-Reply-To: <20250225110429-9120aedc655f1a8f@stable.kernel.org>
References: <20250225110429-9120aedc655f1a8f@stable.kernel.org>
Date: Wed, 26 Feb 2025 10:17:11 +0100
Message-ID: <8734g1ysiw.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Tue, Feb 25 2025 at 11:13:47, Sasha Levin <sashal@kernel.org> wrote:
> Found fixes commits:
> 9da49aa80d68 tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

Thanks for catching this, this one _should_ be part of the series as
well. I'll prepare a v3 with it.

Cheers,
Ricardo

