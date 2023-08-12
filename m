Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D107779DA8
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHLGU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Sat, 12 Aug 2023 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHLGU4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:20:56 -0400
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9853119B2
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:20:54 -0700 (PDT)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 37C6BHjn004750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 12 Aug 2023 06:11:23 GMT
Date:   Sat, 12 Aug 2023 06:11:17 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     stable@vger.kernel.org
Subject: Re: Fwd: Bug#1043437: linux: report microcode upgrade *from* version
 as well
In-Reply-To: <2023081202-storewide-exterior-e96c@gregkh>
Message-ID: <Pine.BSM.4.64L.2308120610450.2159@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2308111943090.32685@herc.mirbsd.org>
 <2023081202-storewide-exterior-e96c@gregkh>
Content-Language: de-DE-1901, en-GB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg KH dixit:

>> would you mind backporting that patch to stables (at least 5.10
>> and 6.1 are relevant for Debian)?
>
>Can you provide a working version of the commit?  As-is, it does not
>apply cleanly, so obviously has never even been tested on those kernel
>trees.

Ouch. Sorry, nowhere even near the resources for that rn :/

bye,
//mirabilos
-- 
15:41⎜<Lo-lan-do:#fusionforge> Somebody write a testsuite for helloworld :-)
