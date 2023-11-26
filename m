Return-Path: <stable+bounces-2679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68B7F91F6
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C32811EC
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0F6116;
	Sun, 26 Nov 2023 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A921F7
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 01:20:58 -0800 (PST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3AQ9KiX8007733;
	Sun, 26 Nov 2023 10:20:44 +0100
Date: Sun, 26 Nov 2023 10:20:44 +0100
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <greg@kroah.com>
Cc: Dan Jacobson <jidanni@jidanni.org>, stable@vger.kernel.org
Subject: Re: Say that it was Linux that printed "Out of memory"
Message-ID: <20231126092044.GA7407@1wt.eu>
References: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>
 <2023112613-decorator-unroasted-500d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112613-decorator-unroasted-500d@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 26, 2023 at 08:48:50AM +0000, Greg KH wrote:
> On Sun, Nov 26, 2023 at 10:40:36AM +0800, Dan Jacobson wrote:
> > In https://github.com/szabgab/perlmaven.com/issues/583 we see to find the
> > simple answer to "What printed 'Out of memory', one must consult the
> > experts.
> > 
> > Therefore the "Out of memory" message needs to be prefixed with the name of
> > the kernel, or something. Anything. Thanks.
> 
> Prefixed exactly where?  The kernel already does report all of this to
> the kernel log, saying what program was killed due to out of memory
> issues.

From what I can see on the original article featuring a simple perl
script at https://perlmaven.com/out-of-memory it says "on the terminal".
As such, it's just the perl interpreter that faced ENOMEM and printed
the corresponding message before quitting. One will note that there is
absolutely no capture provided in the article nor the reporter to ease
understanding, but as a rule of thumb the kernel will not print stuff
in the user's terminal, it will only appear in logs where it's indeed
prefixed. And no need for an "expert" to figure that ;-)

Willy

