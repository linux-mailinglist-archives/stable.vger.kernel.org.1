Return-Path: <stable+bounces-16157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7D83F178
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58361F21961
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5681F95B;
	Sat, 27 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDR8R5Sb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE841F959
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396838; cv=none; b=H0+wVb9MAyPgHE1w6oijWwtNPQONvJLqX6GhbmrGi/9H6U2xlFA6dh7PdbJQTlmzrGQ/jktZcX1PJSKgPW3BbuoVU6qTCFzucrQ8s1bCECfveF4JyNmwAOVWRxlg63Wyv6PeVSmhVvqjM7oegXrEFHg0eLq2CUDa7mQENFRZFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396838; c=relaxed/simple;
	bh=ZfbpBEewJCocnLjL0LR6CrhSQ8toff+XWJARLgVfSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDBUGc6Mg0wHrygFYkK6/7/X4UFrTyhNhTHwycHTsO/cTcDIFTE8qMDx2BHy2PpmO0GFSFgVb5Wog0iH+0N0VCg9k62T9mKUnRfOZ8G9a3N6rpiXrNVP7eFWLJ5gRANgivgAUX+3fWD8k56Lj2JfdLnXbHLezDnw3PhwlDR7LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDR8R5Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1475CC433F1;
	Sat, 27 Jan 2024 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706396838;
	bh=ZfbpBEewJCocnLjL0LR6CrhSQ8toff+XWJARLgVfSBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDR8R5SbViLEuMrUfB+I3iNbzwhEQrYowM2VBJf1XbUj9rm+2+pkPcQbshgjcoTzI
	 XQUkyFmqHd1zQ+vqHEfn8Y7tTfo6+K3KmFWgoetnnNU5g38VUpE71P6+vv1/yiUywq
	 Y7S0dz1XWYgLNdNGWVtGPl0GGm45wvXLTghDtUDQ=
Date: Sat, 27 Jan 2024 15:07:17 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: hdegoede@redhat.com, samitolvanen@google.com,
	srinivas.pandruvada@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1] platform/x86: intel-uncore-freq: Fix types in sysfs
 callbacks
Message-ID: <2024012707-aftermost-unranked-12a7@gregkh>
References: <2024012703-mosaic-geriatric-232b@gregkh>
 <20240127225731.3567660-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127225731.3567660-1-nathan@kernel.org>

On Sat, Jan 27, 2024 at 03:57:30PM -0700, Nathan Chancellor wrote:
> commit 416de0246f35f43d871a57939671fe814f4455ee upstream.

Now queued up, thanks.

greg k-h

