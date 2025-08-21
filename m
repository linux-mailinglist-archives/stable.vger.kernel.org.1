Return-Path: <stable+bounces-171976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB84B2F79C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B44178897
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9875310624;
	Thu, 21 Aug 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vmo-authrelay.edge.unified.services header.i=@vmo-authrelay.edge.unified.services header.b="Y/9QxjYb";
	dkim=pass (2048-bit key) header.d=virginmedia.com header.i=@virginmedia.com header.b="PnY0jlZB"
X-Original-To: stable@vger.kernel.org
Received: from dsmtpq3-prd-nl1-vmo.edge.unified.services (dsmtpq3-prd-nl1-vmo.edge.unified.services [84.116.6.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545A3101B5
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778375; cv=none; b=CeCOibabHh9PaOdn5H5Y9iR1EgCM9Dp8xl2VLSRlQC6XH/HyI94K9WttFo1HnklHK7ne2FR5Mc5UQxfPIQ4NpVIvy8mUMBK4441ODkcmqUMtiv4vb8KWj6Me3E6n+v3fFTggseMFCAE61HlpgF7EKhVjpBXoPx3uWuwbwT+kVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778375; c=relaxed/simple;
	bh=Y1zoB5NtO0s3PFcI0BnvCGvmCyav2YpF4ByjH0GjmrY=;
	h=Message-ID:Subject:From:To:Cc:Date:References:Content-Type:
	 MIME-Version; b=pUGwifjPWD5SiUatDtxQ2YDmrBxEGsy8iEUwyPFzKEFzCCm/Iv5kyBB3Ot/htZy82QbOf+8oIWdu3XDMWuWYyFAL2pWdksw1mRVMUSP7m452cRbHfA61SThpykfji5Yh1gYpx9kcrkLG0/WKVnxIsJKbiqtdPEtF+YX97ijKHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=virginmedia.com; spf=pass smtp.mailfrom=virginmedia.com; dkim=pass (2048-bit key) header.d=vmo-authrelay.edge.unified.services header.i=@vmo-authrelay.edge.unified.services header.b=Y/9QxjYb; dkim=pass (2048-bit key) header.d=virginmedia.com header.i=@virginmedia.com header.b=PnY0jlZB; arc=none smtp.client-ip=84.116.6.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=virginmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virginmedia.com
Received: from csmtpq3-prd-nl1-vmo.edge.unified.services ([84.116.50.34])
	by dsmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf-linux@virginmedia.com>)
	id 1up3q7-00D0eS-PS
	for stable@vger.kernel.org;
	Thu, 21 Aug 2025 13:52:19 +0200
Received: from csmtp5-prd-nl1-vmo.nl1.unified.services ([100.107.82.93] helo=csmtp5-prd-nl1-vmo.edge.unified.services)
	by csmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf-linux@virginmedia.com>)
	id 1up3q0-009wCa-Gw
	for stable@vger.kernel.org;
	Thu, 21 Aug 2025 13:52:12 +0200
Received: from Moira ([82.0.204.144])
	by csmtp5-prd-nl1-vmo.edge.unified.services with SMTPA
	id p3pzuvOYWu43Qp3q0uYbJt; Thu, 21 Aug 2025 13:52:12 +0200
X-SourceIP: 82.0.204.144
X-Authenticated-Sender: smf-linux@virginmedia.com
X-Spam: 0
X-Authority: v=2.4 cv=daF63WXe c=1 sm=1 tr=0 ts=68a7086c cx=a_exe
 a=7KlAsy3RGnwpW11VTsQBiw==:117 a=7KlAsy3RGnwpW11VTsQBiw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8
 a=ULS5oeG2XnDE0pKzhGIA:9 a=QEXdDO2ut3YA:10 a=aVK55nSlM4oA:10
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vmo-authrelay.edge.unified.services; s=dkim1; t=1755777132;
	bh=Y1zoB5NtO0s3PFcI0BnvCGvmCyav2YpF4ByjH0GjmrY=;
	h=Subject:From:To:Cc:Date:References;
	b=Y/9QxjYbdvZkK8vSBeWoYBEruOlV2x6zya4/WAY3gHRIJ2oqjwUisUF+n0nVHu1nF
	 xdtaYitMwpn+Z1h5Td9tA8TRzUJKs49Epb7ZNNVcpMPiCZX8zMvkUvwpJCwnmscFLw
	 kNNqAUPhlkWYiiMz/Ngt5JKGd19K5tr1W+b6UvP7hvYnDFn37IH5DYoJ07IIdCeD3G
	 1YHsgX+9Chd3jsZbz3RSHmR9aWGd0qvHHFRrFlUPJce7jl2cJyCjGIzjpUR2AzKC7Y
	 13oFkcx1xtmc3Txn3LzFOpbAZm50n6uHiHYObkMVf6Gww7Kl1ksqn0rnMyQxkL+YnI
	 ESqrMsMIKFxpg==
Feedback-ID: 20250821-??:csmtp-prd-nl-vmo:Authrelay:??
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virginmedia.com;
	s=meg.feb2017; t=1755777132;
	bh=Y1zoB5NtO0s3PFcI0BnvCGvmCyav2YpF4ByjH0GjmrY=;
	h=Subject:From:To:Cc:Date:References;
	b=PnY0jlZBftJplisadp74O7E/fFYo6ielejlVep24OpM3sOa/gwT9BP26QtDX5JzR5
	 HnGygoiii0vicoaoZ47YCKSlWJotg2Pj1IpqJekIowiDqmveMYFrZ74TkVLQDc3rho
	 4i3hGllINXJN9S0hV62vkdlsm/USm/PgmdlqRWBekR9HThxm9qIBY6Oz1H8aa165CQ
	 Fs7EGYd9XNPzCUazC7oPa4bGcoPMdShQwgP5/SdlZ33w4z850CBilPkFl5DzGL69st
	 yyj2wiDiu7TjZocodGGIOsdrG1MSHzwLh1qzFXOwV2m06mgBhH8sGXDpd0VWvzz/hi
	 HxYzBdkl+AOTA==
Message-ID: <4623e321608f5fb1b1e9097b8651b95918b1e0e6.camel@virginmedia.com>
Subject: Fwd: [Bug 220457] Using -march=native on linux 6.16.1 causes: can't
 find jump dest instruction error.
From: SMF Linux <smf-linux@virginmedia.com>
To: stable@vger.kernel.org
Cc: aros@gmx.com
Date: Thu, 21 Aug 2025 12:51:57 +0100
References: <bug-220457-19080-Tat6iJZuvD@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CMAE-Envelope: MS4xfD21dogFl6zyNkq9/8tim1FH0SCC2uoOpkAIBlAHi/zrMpQwiuVEkvmRQQo+TxoEUx3ksm1AmGnNNc2v3nayvAkPtN0AoxfST0XXnU/WI4LJwE5kFUOm
 ktyl6d3jQXab8GkBu1r0Dh5otwEDu5Q4hfbRIwfGTc1gdVgncn5cm/zZL/neNmiGc+l6I6CGK99mx/j33e+xqtS3tkb3oF1dxEc=

https://bugzilla.kernel.org/show_bug.cgi?id=3D220457

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Send this to LKML. This bug report will die here unattended.


