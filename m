Return-Path: <stable+bounces-151320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B395FACDB5B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EA1886E8E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3128D82F;
	Wed,  4 Jun 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhVdr7d9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3528D829
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030417; cv=none; b=dlDuBOnVWVFTZq6jdiSQFl2Ynwr9zyOq8H10vito9pmgDKiXKwPD9RHs0S01sc/jNvqcka/raTJa/SJg4sAm3IE++uUiQE4Rum9be7cPc7o6l5pajjoWE3BL4lE/dzZ6KVlN4ohLW2G+TQWc3sXY89gv7ciuah7ha00j1axj+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030417; c=relaxed/simple;
	bh=kKPwFkCFGPU7X56dQpWpV4hdOYULBXetKyVnaSQxqrM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VnPjN92LkvWJtAn4l08huTrMKrWwpmkZ0iZfstklb5ixydh8Pp8PVLv/FI6EAxwYFpgK2R1yFK+D9Ds8oYDa5gu3iPKnhi/bbrlCUjpHTlJFkWAkJH9Bg2+3BpEc5BO8QHBo7cnbuYA5OKgBLwZ1C+qyKWwBtKK/fACGA+d03e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhVdr7d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC67C4CEF1
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749030416;
	bh=kKPwFkCFGPU7X56dQpWpV4hdOYULBXetKyVnaSQxqrM=;
	h=From:Date:Subject:To:Cc:From;
	b=FhVdr7d9MHzNIfuImD2xfWhUUBTtIoWKaFaSBAX1WCnkL/5BOvKaese382FRiOsv7
	 vmuMYo//LFRrt8QMq9kxuRcMYhGJgGYzv3Z3yMx848jmpp7IQ80JNC38M1oERhkoVn
	 2BQaF809C/80W38aeqCb0j9rKlv5+IcptD9HMfuIyJQ40w3QR5wfNNjrJwHISfHXgx
	 RiJVn24uYcgDYYjPNNTFWKBCnFIK9RNW2cP3pIBCgG8dzQwRVVDM/+634N4vFAQ6Pt
	 o1E9azxmhUfAMIXSNx1DOn+PNM8rIgF3WGzmesXq0D9zTAMvEDLig92gLRgy5JWGJ7
	 WJuB5ScAR0gJg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60efc762612so1023684eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 02:46:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0/mHu04YIAOCy4tISdqJwUdFJ42PMF8sxkVKAg7WkZKlNKg0pkcGhLON3C3SeMJJahElxSEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgyWH4YZLCtc/5znzHST5mJRJqqEz286GqtiKGg7jnPD5k+6z
	X1mWT/JyWqyPjCbVgixhxtsX82g0eYB4U7MgjxnQhSCqzHVX8WlLbRmZHocneHCNKLSPNOUiEiY
	7iCNxLsEB3GZfoHVXwm/U3CbayFnm3K0=
X-Google-Smtp-Source: AGHT+IFJIj0OD/tHS/rupOTZkdufl4zPWFN6162vXLHFBBBc2uq9lmrk+LlJ5GSro7f8Byz/jpPxoNsMl2dvbHQizxQ=
X-Received: by 2002:a05:6820:1e0e:b0:60e:c93a:4b43 with SMTP id
 006d021491bc7-60f0c6e0a08mr1410335eaf.2.1749030415895; Wed, 04 Jun 2025
 02:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 11:46:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMdbP_ZHY3t4FKSXfoBmXi_gh0Yp4Mdy-Uuk4Vti6ZGg@mail.gmail.com>
X-Gm-Features: AX0GCFvSzShbcF2vCwIVsvJ7QRcBRp2O2RhRGYvPgfmY_1BFdji-IREl6gfs7yA
Message-ID: <CAJZ5v0hMdbP_ZHY3t4FKSXfoBmXi_gh0Yp4Mdy-Uuk4Vti6ZGg@mail.gmail.com>
Subject: 6.15 bug fix to backport
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg et al,

Please pick up the following commit:

commit 70523f335734b0b42f97647556d331edf684c7dc
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu May 29 15:40:43 2025 +0200

   Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"

for the closest 6.15.y.

The bug fixed by it is kind of nasty.

Thanks!

