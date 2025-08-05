Return-Path: <stable+bounces-166526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEAEB1AE20
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD0318940C6
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089720A5EB;
	Tue,  5 Aug 2025 06:20:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5D175A5
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374837; cv=none; b=RdCHY9iEzXLkHQ8novnChS7ZGcdKY6doGAnlCYUXfz9L1REQ13tP7TARQzIrhXTCRrMAa46fXDHuw9BTaeB41pDtuhqnNDyHJWKAVh6RHeS53a1FhGbF2gJw9FcvPqyPq45GHd09+tzUmRYzmNqgEJt/EEt9Lj4cqxA04U0OfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374837; c=relaxed/simple;
	bh=9zGSzBc2f0ILDyto6CwWsQRRv7Y1U8Czxh2Q1Nq00KU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ed6kzIEjUwYz5oRSpV05bCvQXJDxnvy/a++8itULkyHdyF/diWcGd5TgGuhc+dxJ8Fqd5x/nN322g3IEWcRGpLd+2s5PrLLRVZ4OvrRoRrhOy9IFfkm3+VuNxZXu1Zs+6KlINofhCoUhzCWvPTG5zLZMGQtNSCJsCMUPgZZHuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bx2tF6Nrjz9sFT;
	Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwMz0SDajMtN; Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bx2tF5gtkz9sD3;
	Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BEF698B765;
	Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id V3D-rJziP3v6; Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B9418B763;
	Tue,  5 Aug 2025 08:03:49 +0200 (CEST)
Message-ID: <7240379a-176f-4187-a353-1e6b68a359ce@csgroup.eu>
Date: Tue, 5 Aug 2025 08:03:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-stable <stable@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Apply commit 5a821e2d69e2 ("powerpc/boot: Fix build with gcc 15") to
 stable kernels
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Could you please apply commit 5a821e2d69e2 ("powerpc/boot: Fix build 
with gcc 15") to stable kernels, just like you did with commit 
ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")

Ref: https://bugzilla.kernel.org/show_bug.cgi?id=220407

Thanks
Christophe


