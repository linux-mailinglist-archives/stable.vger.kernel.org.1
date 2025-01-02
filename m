Return-Path: <stable+bounces-106636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024199FF57B
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 02:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9211882148
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B34A00;
	Thu,  2 Jan 2025 01:50:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDC8F58;
	Thu,  2 Jan 2025 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735782602; cv=none; b=p+iUEfknsOrjiol2G2G8AqqQ2z16ZYcjAUUoLe3I44G50skrcNmUgx7+cC4jSgoOnpXrQSdVfsvwt3hs6f2IdVXgjPo8ACYPdatI/h19itWF6ASOwdiu+KMPRN52w6TfBV4vU/I1E5qxPi7q69MInhWDu8yvy/Ail/nHEQY+6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735782602; c=relaxed/simple;
	bh=ewUhBs+a5wKT2xgr++ikbOYNpWCsfy8aZOAOYz8HYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPt3TChg72Q6RZuhArKUB14Rdvy3PrM6ko76xCA9t2AUcSrJaf0qcAy+RN/ViZYoiZD0X76T//EWIZ14gtom/JwMbd6Id93h68pDykquHq1t/ag9Lk69F3HMhW40BzsaWE38Z9SddIcBnvcJmGACsfuzMeNMUfPOwxYxxWOhdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED26C4CECE;
	Thu,  2 Jan 2025 01:50:00 +0000 (UTC)
Date: Wed, 1 Jan 2025 20:49:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 lucas.demarchi@intel.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
Message-ID: <20250101204959.6e297af6@batman.local.home>
In-Reply-To: <5ca1c5b64c313108ea2aa005ae273f1ba8051e7f.camel@linux.intel.com>
References: <2e9332ab19c44918dbaacecd8c039fb0bbe6e1db.camel@sapience.com>
	<9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
	<20241230141329.5f698715@batman.local.home>
	<20241230145002.3cc11717@gandalf.local.home>
	<5f756542aaaf241d512458f306707bda3b249671.camel@sapience.com>
	<20241230160311.4eec04da@gandalf.local.home>
	<0ef755e06b8f0bf1ee4dfd7e743d6222fd795b70.camel@sapience.com>
	<5ca1c5b64c313108ea2aa005ae273f1ba8051e7f.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jan 2025 21:55:26 +0100
Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com> wrote:

> FWIW, we actually worked around this during the holiday in the drm-xe-
> next branch in the xe driver since it was breaking our CI. Was planning
> to include it for drm-xe-fixes for tomorrow. Since xe appeared to be
> the only driver hitting this, our assumption was that it'd be better
> fixed in the driver.

The driver wasn't broken. I changed the verifier and it incorrectly
flagged that driver's trace event as unsafe. Yeah, it's the only driver
to use an array of strings, but it doesn't mean it was wrong.

-- Steve

