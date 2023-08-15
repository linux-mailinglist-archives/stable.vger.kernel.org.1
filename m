Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817277C723
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 07:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjHOFgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHOFeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 01:34:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CC5A171F
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 22:32:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37F5VW6p022665;
        Tue, 15 Aug 2023 07:31:32 +0200
Date:   Tue, 15 Aug 2023 07:31:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Xuancong Wang <xuancong84@gmail.com>
Cc:     security@kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: A small bug in file access control that all have neglected
Message-ID: <20230815053132.GB22301@1wt.eu>
References: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

On Tue, Aug 15, 2023 at 11:42:55AM +0800, Xuancong Wang wrote:
> Dear all,
> 
> I found in all versions of Linux (at least for kernel version 4/5/6), the
> following bug exists:
> When a user is granted full access to a file of which he is not the owner,
> he can read/write/delete the file, but cannot "change only its last
> modification date". In particular, `touch -m` fails and Python's
> `os.utime()` also fails with "Operation not permitted", but `touch` without
> -m works.
> 
> This applies to both FACL extended permission as well as basic Linux file
> permission.
> 
> Thank you for fixing this in the future!

Your description is unclear to me, particularly what you call "is
granted full access": do you mean chmod here ? If so, you can't
delete it, so maybe you mean something else ? You should share a
full reproducer showing the problem. Also, the fact that one
command (touch) works and another one (python) does not indicates
they don't do the same thing. So I suspect it's more related to
the way the file is accessed where both commands use different
semantics. As such, using strace on both commands showing the
sequence accessing that file will reveal the difference and very
likely explain why one can and the other cannot change the last
modification date.

Willy

PS: there's no need to keep security@ here, it's used to dispatch
    issues to maintainers and coordinate fixes, now that your report
    is public it will not bring anything anymore.
