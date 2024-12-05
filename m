Return-Path: <stable+bounces-98827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1FA9E58BB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2D4284357
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC62185BF;
	Thu,  5 Dec 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DStHVWPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C111E49F
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409921; cv=none; b=WCAKGZ/QfU1vImcewBLDt2JSIH3hV+v+GsUHQy69N3Eghwu9+ySe9UNGiHLfLdZ2yFnzsGf0+6QRJUlvEie2lS9d1Wrq9B9viwLG2q5/U+y1tljygwDqmKiSkhjvbYe+PVBYhtmAmS5OQJcB9D1Y4R0R5bx5ntw6uWdgNQH84AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409921; c=relaxed/simple;
	bh=AKik/3BthImWfC3FdImCbvkSue9P69YY3C0K0cahkR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ1nLgjeIJwlFID47qrWNXHoq4IyqS+J9zcewUZtFxM9haHmlVPFYygU/cb6BxgilrRudD4gdA9Wt0Cirp2q8QXvhlrXmP/NO18cSW3QKOgVdjhz9vbVNyjO/GM74jDAPaOxHBv1IGXfGdFmvEc9gbjQ+KDxmGoUnO+bG0bVri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DStHVWPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E4C4CED1;
	Thu,  5 Dec 2024 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409919;
	bh=AKik/3BthImWfC3FdImCbvkSue9P69YY3C0K0cahkR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DStHVWPI3GsQDBM8e8VkM15akkX/gSA2LxT6FXFNreFeoSpwfDsjv1BUizFIqCVfp
	 UPqeHtBXBGxkvY2UvDl/bgsw2svcTHkt5/IoRwTS+wSLBBjkvuxTcHv6PQ1xrV9Qhi
	 MruV44ujtpXV/yV631vRBkIl4tZ7XvMHwx5orL0CV02Xlb2ziE5AdzYiZezXRUvJVr
	 ipqmHzCPWwhLvwTAUKEaUO+hWDVQcSXYcLQF42xDUl60ahlweUZMo7lOgUIQAEqh1k
	 i6y0VhFFeB4Fil5KrlpsEPYcXPyT38zzTAFN5bhRWoivD4n/bWG0y/3h8sQa2qmBEg
	 m9Qin6FQqgrCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hardik Gohil <hgohil@mvista.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Thu,  5 Dec 2024 08:34:00 -0500
Message-ID: <20241205071412-80378c1187c2220a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 2663d0462eb32ae7c9b035300ab6b1523886c718

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hardik Gohil <hgohil@mvista.com>
Commit author: Kenton Groombridge <concord@gentoo.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 26b177ecdd31)
6.1.y | Present (different SHA1: a2bb0c5d0086)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

