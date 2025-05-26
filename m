Return-Path: <stable+bounces-146358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4811AC3E48
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925C918980BC
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893718A6AE;
	Mon, 26 May 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="j5Mc9MtR"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2A13A3ED
	for <stable@vger.kernel.org>; Mon, 26 May 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257602; cv=none; b=fe1RbY7UO0yIZvhbrT8lfUq/9/QZ9u+D/S53ICX9aUmp37fwjyw4/IEsBRT5Pr8YceayZujBC6U2FDbLCEXJrPuSJ1IbON6B09jX9c2B8WOfinetz6rlapUiH9OZk5KiusSfOIt71F66VChBu+PJWvXOlgKG5Yo0hpf0t9NyDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257602; c=relaxed/simple;
	bh=2p8oB/NeHUanmo6EtOv+ImcTtHwzJk+VMfxXiiHzJ1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qmRUT1u9+GGssaPVxZNnLlKORjHTOQ1PBNDBved65L9sWlK3HI27a272Tfuz5Yn0RfFasaIYn8lTp+VPeoV5wW0OzLQ899jckYbi8HA/EurtLTGnQNLqb+3IYHVcq/9ohmOwa0eZoBxE875wQc0DcWFTQxM6YyKJn/MpyB2qmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=j5Mc9MtR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2p8oB/NeHUanmo6EtOv+ImcTtHwzJk+VMfxXiiHzJ1s=; b=j5Mc9MtR9jO+okfAoYVygMErxx
	3PJBJZk696epWSyzZB0H1Xko2z3vEPqAP9WVjMEKJQgegqgrbBtyxW24IgwrZoR4CyiI+nGHU3do4
	S6n9MADG6VvufYQT8u+F8mJNAN0Fh3tj4xyg/+2+Q8OTqm+I+XG8Ih4LD/CDEkQutBxrioe58Mgfj
	5t4ZredQtJ9NIWiwt96rJvEVbqVZFC4f95IGSpRQ68sfpgoe2cw/MRjChNgi4uDSFnNVN85ZC8rmM
	sUFHVooxckCKIGufElfsxR8eZDJ8FfvX2mpsaIFmD35Exm91bX/gi3XswEG4gyVKwDgxUhgl86YAj
	4ZXKylsw==;
Received: from 53.red-81-38-30.dynamicip.rima-tde.net ([81.38.30.53] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uJVf2-00DHRx-NO; Mon, 26 May 2025 13:06:28 +0200
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: gregkh@linuxfoundation.org, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, jannh@google.com, lorenzo.stoakes@oracle.com,
 osalvador@suse.de, revest@google.com, stable@vger.kernel.org,
 vbabka@suse.cz
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: fix copy_vma() error handling for
 hugetlb mappings" failed to apply to 5.4-stable tree
In-Reply-To: <2025052601-directive-strep-6b85@gregkh>
References: <2025052601-directive-strep-6b85@gregkh>
Date: Mon, 26 May 2025 13:06:28 +0200
Message-ID: <87cybvbphn.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg,

On Mon, May 26 2025 at 12:45:01, <gregkh@linuxfoundation.org> wrote:

> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This patch was superseded by a v2:
https://lore.kernel.org/all/20250523-warning_in_page_counter_cancel-v2-1-b6df1a8cfefd@igalia.com

and it was ultimately decided that it's not worth it to backport this to
stable. This was discussed here:
https://lore.kernel.org/all/0b2a5a80-0709-452f-9815-018cc1cd14fb@lucifer.local/

Cheers,
Ricardo

