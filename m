Return-Path: <stable+bounces-95794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5669DC250
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 11:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41EF2845C5
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21940198833;
	Fri, 29 Nov 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pYJKblk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9E155345;
	Fri, 29 Nov 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876888; cv=none; b=BPI8q6+9+zF1mOcM2MDvFg3OmcmYGN/jWpu/zj8fNneTyZ/uWY+Osl/zrCvJsNnJQPkvnJoN01Fn5iLws0LdE+KWXUGJLnjYEZB20C9PHq3I0DWiknQCRDI9glhnyI5bpKpYgpxRl9fqCrh7lbuVKaVkyRGuV1itUkzN410jYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876888; c=relaxed/simple;
	bh=hjOK0zywSeokD3DvA4azctX4cWAnxYzpu0R5TPG192g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GV1wFY2oJSS0d6pgdxaaAXy6Tr8kJ0OT5oxU/wxDqXH6EzMuipYuc8Ryoft/8FM6aAySCs3YdA6C2B7YWELEC7+j5oyohVHecP0Pee6oUPRwGCIU5IJuoBHfJMI3JGbIuRlZgVW9pkddwJkONVLQ5A2Oy79irKYMhuKgBvxOne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pYJKblk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BABC4CED2;
	Fri, 29 Nov 2024 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732876888;
	bh=hjOK0zywSeokD3DvA4azctX4cWAnxYzpu0R5TPG192g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYJKblk+fhZ7TJuHqJ10qD1WMfJRsstNB9mSpwXkfGW5OWEmKthLmc2XlmhfJK0z9
	 D5/TNREub82nIMd6n0kVWL/jtm/qP/wPTvsOniF6BgbDySRZY4TBAFLTNnck0cTsFY
	 S2RH9/LtiVzVFctHpds8WHi8Ww0mVf9y1nv7wsho=
Date: Fri, 29 Nov 2024 02:41:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Zi Yan
 <ziy@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, David
 Hildenbrand <david@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] arch_numa: Restore nid checks before registering a
 memblock with a node
Message-Id: <20241129024127.a150e574c57e05b3b3b2a96f@linux-foundation.org>
In-Reply-To: <Z0mIDBD4KLyxyOCm@kernel.org>
References: <20241127193000.3702637-1-maz@kernel.org>
	<Z0gVxWstZdKvhY6m@kernel.org>
	<87y113s3lt.wl-maz@kernel.org>
	<Z0l6MPWQ66GjAyOC@kernel.org>
	<87v7w6sa5s.wl-maz@kernel.org>
	<Z0mIDBD4KLyxyOCm@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 11:23:24 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> @Andrew, I can take both this and Marc's new patch via memblock tree if you
> prefer.

Go for it.

