Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081F7797FA
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjHKT5B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Fri, 11 Aug 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjHKT47 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 15:56:59 -0400
X-Greylist: delayed 719 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 12:56:52 PDT
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ACB8171F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 12:56:52 -0700 (PDT)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 37BJi6MU018962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 19:44:13 GMT
Date:   Fri, 11 Aug 2023 19:44:06 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     stable@vger.kernel.org
Subject: Fwd: Bug#1043437: linux: report microcode upgrade *from* version as
 well
Message-ID: <Pine.BSM.4.64L.2308111943090.32685@herc.mirbsd.org>
Content-Language: de-DE-1901, en-GB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

would you mind backporting that patch to stables (at least 5.10
and 6.1 are relevant for Debian)?

Thanks in advance!

---------- Forwarded message ----------
From: Salvatore Bonaccorso <carnil@debian.org>
Message-ID: <ZNXJui6POZ8Wb6lp@eldamar.lan>
Date: Fri, 11 Aug 2023 07:40:10 +0200
Subject: Re: Bug#1043437: linux: report microcode upgrade *from* version as well

Source: linux
Source-Version: 6.3.1-1~exp1

Hi Thorsten,

On Fri, Aug 11, 2023 at 07:23:57AM +0200, Thorsten Glaser wrote:
> Package: src:linux
> Version: 5.10.179-3
> Severity: wishlist
> Tags: upstream
> X-Debbugs-Cc: tg@mirbsd.de
> 
> I have this in dmesg:
> 
> [    0.000000] microcode: microcode updated early to revision 0xa4, date = 2010-10-02
> 
> It would be very nice if this message also showed the revision *from*
> which it was upgraded, so that info is available without going through
> extra hoops to boot without µcode upgrade.

This is fixed upstream in a9a5cac225b0 ("x86/microcode/intel: Print
old and new revision during early boot") in 6.3-rc1, but not sure it
will have changes to get backported to stable series upstream.

Would you mind trying to get that applied in the needed stable series?

Regards,
Salvatore
