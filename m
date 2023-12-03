Return-Path: <stable+bounces-3816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03C802739
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A0A1C2092E
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A218C20;
	Sun,  3 Dec 2023 20:20:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A0192CF
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:20:33 -0800 (PST)
Received: (qmail 360340 invoked by uid 1000); 3 Dec 2023 15:20:32 -0500
Date: Sun, 3 Dec 2023 15:20:32 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: gregkh@linuxfoundation.org
Cc: niklas.neronin@linux.intel.com, mathias.nyman@linux.intel.com,
  stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: config: fix iteration issue in"
 failed to apply to 6.1-stable tree
Message-ID: <8cef0c36-adb1-4a90-aafc-ca8114381125@rowland.harvard.edu>
References: <2023113059-unfunded-blasphemy-617e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023113059-unfunded-blasphemy-617e@gregkh>

On Thu, Nov 30, 2023 at 02:49:59PM +0000, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 974bba5c118f4c2baf00de0356e3e4f7928b4cbc
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113059-unfunded-blasphemy-617e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> 974bba5c118f ("usb: config: fix iteration issue in 'usb_get_bos_descriptor()'")
> 7a09c1269702 ("USB: core: Change configuration warnings to notices")

I believe the second commit above is the cause of the problem.  Since 
that commit has now been applied by Sasha Levin to the -stable trees, 
you could try re-applying this patch.

Alan Stern

