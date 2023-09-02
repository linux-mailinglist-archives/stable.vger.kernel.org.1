Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D51F790A3F
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 01:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjIBXHK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIBXHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 19:07:09 -0400
X-Greylist: delayed 173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 16:07:06 PDT
Received: from cmx-mtlrgo001.bell.net (mta-mtl-005.bell.net [209.71.208.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8887CFE
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 16:07:06 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.198.135.111]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64C3528203335C88
X-CM-Envelope: MS4xfCZV9U/yPgj7+HROGzGHBlXsIEzaEWiNhhVFpnpBSAz36lUysIlGYAK827DlBqvrkWyMXamUYceL0m2BvmQzZS9w3At3H8iwbXr+QHJUXx7bo5iXHXCC
 Hv+gZgEB/5R12RMf3MrYbx7Ow6sGmgghsp7rSwDqsKxyN45TvgNhJ90xMhl7vKvkYUh9cJTzY177y3J4x+5oWtwF/zL2bn293728lcqmTVaGu8gPf0/DNtKG
 fsPd2jg8Y7Qdl5c28sRpQNigD0a/LuFZ9U6I5BXLvnzN75OqKm4HB7RucklibJyE85qax8f/emdGElJfGJxo4oqtIxLDX7yVxbQMOczw9hMTROMFaYqqDXvU
 P7zAuPzB+m7Om5IRBJg9j2eKI6yvSXOWBsFiOxf6N8SOHn4aaNigb/2pwVilxXFs9CH1phpMPtdiszsr/lcQbQ/u2fArsIFzUDkTbOvh7toxpqHQyNs=
X-CM-Analysis: v=2.4 cv=W7Nb6Tak c=1 sm=1 tr=0 ts=64f3bf69
 a=m0hBPjpnfWKpZW+YOe+Hqw==:117 a=m0hBPjpnfWKpZW+YOe+Hqw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=ZjPAgu6vkrefqVqYoh8A:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.198.135.111) by cmx-mtlrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64C3528203335C88; Sat, 2 Sep 2023 19:04:09 -0400
Message-ID: <8f6006a7-1819-a2fb-e928-7f26ba7df6ec@bell.net>
Date:   Sat, 2 Sep 2023 19:04:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [STABLE] stable backport request for 6.1 for io_uring
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org
Cc:     Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>
References: <ZO0X64s72JpFJnRM@p100>
 <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-08-30 12:17 p.m., Jens Axboe wrote:
> On 8/28/23 3:55 PM, Helge Deller wrote:
>> Hello Greg, Hello Jens, Hello stable team,
>>
>> would you please accept some backports to v6.1-stable for io_uring()?
>> io_uring() fails on parisc because of some missing upstream patches.
>> Since 6.1 is currently used in debian and gentoo as main kernel we
>> face some build errors due to the missing patches.
> Fine with me.
This is probably not a problem with the backport but I see this fail in liburing tests:

Running test wq-aff.t open: No such file or directory
test sqpoll failed
Test wq-aff.t failed with ret 1
Running test xattr.t 0 sec [0]
Running test statx.t 0 sec [0]
Running test sq-full-cpp.t 0 sec [0]
Tests failed (1): <wq-aff.t>

Dave

-- 
John David Anglin  dave.anglin@bell.net

