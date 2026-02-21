Return-Path: <stable+bounces-217625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NtdBEVImWklSgMAu9opvQ
	(envelope-from <stable+bounces-217625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:53:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715516C38E
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5073304EA9F
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1783370E4;
	Sat, 21 Feb 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgsD7Srv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B4336EC3
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653164; cv=pass; b=JyNp4F92tgLzPuf75QhjMGc8u82ecxygAbP+5qIwcOkor839+V0+A35k38zjUvPPD2z2Tg0bO4jFu7lnggYP0C3MpMQ2wpZzY8zdp25itI6wYu7HPjU8JgFBc6jM0zUX2dHnc13vpCjh9KmRUv4bGrlqhgeLMgbY31+O/F6wZi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653164; c=relaxed/simple;
	bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl/2ay3R/BbZpdTRXZt853/+OOJZTeSjh5G6nwG+bfzeHDj1o9v0bDJhqokD0icJrRi7yBu4o8pMzoIAUaC/l6oXJjBzZ+bhQhpVVI3KkM2UgnvdPb9yI37y04kOlH2og/YtPwl4OO8w/WMFQcQSZJEVdh80zuvdHLIVlugDqa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgsD7Srv; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f9568e074so512054566b.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 21:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653161; cv=none;
        d=google.com; s=arc-20240605;
        b=YLzrFOiYfDr74wGlQzKVjJjhQ3dgiNsJs1I5jGM6q7nibqRGHwYmD8qu2HuTixmMVR
         7JfgD9E8DlowwOCl6gCpTSYOUJa0kBrrMMgZUCziKhHW1H6wTWVuXJZXdiF5s0yguo6w
         /e6GLJinPbteWUBVLfasNM/Ttsuu9qLNmEVX1lRTgP8z5TMZQKnIrnk0hTdlXdkhaaTq
         a3CsCQOZKgooa5GEgSefDQiTa73Fci/0gRiCop5X/WPLVBlGwKIjhV4g7NzmatDxzvgM
         J/m58+zRZStCdMhWiw0XlfpzuPeJWbkDH7pqlzGRNLDmKsLLxwKcud+QVMtVN24+yJha
         7Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
        fh=iLryWfP5D+1yWWR82cy56fWpQuLvIOi2LdE+FlaUCEY=;
        b=gwnidsnZA7eRMZE4/SKBXHkk+uvT0oBA5l8zc4Vk9kL8M1VFi2AseyBtBd4dUwTaLt
         Jf5G/mkLiaubEwXhc+LF0zy9w2Cuw/1bq4G5K906PmkZB4XvCpyQM2qdixL9JOkP0lwR
         cxluM+NKo3CuGbFj052IZ3UkS2hTNdeiS7h7InMr/YH8JHOacL1ZOJY9Qfi4TOr8oPRs
         doD/++e/R2Cir/5UhlNhJdMfMV6ld57lCES223Ppe6acD5IRO4NfC4rRbw67JUYnd2to
         splMQw9PN1SijFdIlvpMb7Br3xo+bGM7AaBpM6IEH6sDqAYcFAPwq6XnBSlMHKa7bnqC
         JQFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771653161; x=1772257961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
        b=RgsD7SrveLcwqgNjZEdbrkKNEOm6jLym3Aaon/9I0aexhYLC5CRPYMxmISRtF/6uwW
         4vmbqeV7WWzL8jYc0MP2FMHEvkJksWQ0IM/FRyfwNei7QId3Ybb3cQPwPoYsDYaen9NI
         yF5KLYmNBw62kEnLMidu6yohqFgKZk8LucXTylHrkMg/483eeuHuPK9S8AUNPBUgBLPN
         7MkzdxBgGYvAcjhVRT7McveHv5KRMjXimcnN6DnpTE3cGu+hduX0YCc3UNAx2SgYv6IL
         v9AdoLzsvcstOW/WltyDCbeDfat4Vj7iPPdOnvuCB0H7B+o6+d/n0WNbMud3CfI0K2BP
         wRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771653161; x=1772257961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
        b=KkY6jqkjGnpAJnl/7ct60LGmzitRMFwCLzm8jD9P1mNC7Y0+R2nYgUbdTBRMUH9bVB
         fsyLdAuUIaD48wOXSNoLDviVr1X4oxGN2f6zWDjIZ0lnXOP8wRgnepSP3bN4KbsAQgIy
         cDFn6N/886dJWikea0LbjXmO85BWUcrxqGols1SYFC24HYZ+mNxPovGrYxKanIwS8nsM
         JY4hplBG/NZVL652HCcuEYAJDHG1f2upFPYD4GxWgXMbv+D0NOuYKu5rxVAZBZUva6ZB
         dZfkss4r/G3Lxrb3AYYKb9L72eVs0TOiHwn11GwSNyf61jPzwqqSbgshWBULHfvoxRRz
         pffg==
X-Gm-Message-State: AOJu0YzbBtHstkL4oT68vXDHlRdeo1tnptws56icGqVIVGcmacT0lbe6
	4LEhTqekZEkxLVN4shP1rhjbcNvbFix5DmjXktOsi/DMS4DvekQcaVtyIQntw9iZWwLtmleVqS1
	bRDWu8BsqgyUPN5i+jRs1Kf7xCI5L/lM=
X-Gm-Gg: AZuq6aIPGYal/PDoalj19xC3wqQ6rrFE+3wo8Mc2qT+LrDlRa2A3S8zWI7++cvj3H3+
	Rqh9IV/ViJWfI24ulsGtOoPrNHbiBuixpFoLM8vAndCGygqo4t6Q1sPZul161QU5mxy3Cg5FkPj
	7gpr2ruf56idg0tlkCRSRUf4nskQ0vP90vEjWFE+gjooqLs4mmrJzfbyRFzXfseQFcbjw6iZI9w
	n4F5Vieo5LtQsD6iu6bz5rM2XOvTMSJtbHD4ss3EvAvI1Z3jTZerRN+Gz7DckBQLOnx8iXB7wck
	KG1Q8PGACpnO7okSXx/nwfQZc6F4sw43sws+TQ785E+F5DndpnQzjddhV12wdVoU8RkasHul31Q
	X+1QGfw==
X-Received: by 2002:a17:907:a43:b0:b90:a99:6ab5 with SMTP id
 a640c23a62f3a-b90819947dcmr118481066b.7.1771653160995; Fri, 20 Feb 2026
 21:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com> <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh>
In-Reply-To: <2026022148-unsorted-pushover-8262@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 21:52:29 -0800
X-Gm-Features: AaiRm51kvzm1-uW1evSUVzI8gGGopob0vMQaVVrKbOjRlGOELAe0rmEnSeUjXGI
Message-ID: <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland
 with high pixel clocks (v3)"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217625-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6715516C38E
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> >
> > This commit breaks stable kernels older than 6.18 that are booted with
> > radeon.si_support=3D0 amdgpu.si_support=3D1 amdgpu.dc=3D1
> >
> > In 6.17, threre are further commits that are needed to get the DC
> > codepath in amdgpu for Southern Islands GPUs working but they seem to b=
e
> > too much of a hastle to backport cleanly. The simplest solution is to
> > revert this problematic commit
>
> Ok, this is better, but still, this only applies to 6.12.y, right?
The reverted commit (or rather the one from master) was backported to
at least 6.12 and 6.6. I didn't check what other kernels include it.
>
> thanks,
>
> greg k-h

