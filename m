Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925ED730929
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjFNU24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjFNU24 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 16:28:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDB32110
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 13:28:55 -0700 (PDT)
Received: from [192.168.1.10] (c-71-231-176-209.hsd1.wa.comcast.net [71.231.176.209])
        by linux.microsoft.com (Postfix) with ESMTPSA id D764920FEB21;
        Wed, 14 Jun 2023 13:28:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D764920FEB21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686774534;
        bh=SMOHdXUAU+6LnCJQbH9osi2tpNReAdc/vdiXOB6vf2U=;
        h=Date:From:To:Cc:Subject:From;
        b=KYBCLdkLo/wfehdG18I+8vPq0EEyDbRAYlm4QQjA+jcf9PGcTzPGWQPlMTUOjwTKU
         ctIInlx8wQ2EB5xyl5KShq8Qs9O3m/eK1hLsFp1H5CvrQb0u4GZA/MuAPoYqDFkCyp
         +vtTHKLKyjhqZzh9lWH9nM0QE55n0e+TU4lQXxdg=
Message-ID: <5f49c8bc-1eb7-be99-a1a8-7d7e0e87ad1b@linux.microsoft.com>
Date:   Wed, 14 Jun 2023 13:28:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Hardik Garg <hargar@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     code@tyhicks.com
Subject: backport d8e45bf1aed2 (selftests/mount_setattr: fix redefine struct
 mount_attr build error)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit d8e45bf1aed2 upstream.
(selftests/mount_setattr: fix redefine struct mount_attr build error)
Backport this commit from v6.2.0-rc5 to v6.3, v6.1, and v5.15 to resolve
the struct redefinition error:

mount_setattr_test.c:107:8: error: redefinition of 'struct mount_attr'
107 | struct mount_attr {
| ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
from mount_setattr_test.c:10:
../../../../usr/include/linux/mount.h:129:8: note: originally defined here
129 | struct mount_attr {

This error is caused by the upstream commit f1594bc67657
(selftests mount: Fix mount_setattr_test builds failed) backported
to v5.15


Thanks,

Hardik

