Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61E74BB76
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 04:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGHCrd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 22:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGHCrd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 22:47:33 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE569C9
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whu.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
        bh=BLZZmKZhI+wxmLaYc2p5It3oWeMowcKyCWiS7QfHkL0=; b=P/k4JMNb6NAdC
        WZHoU+ZZnoe/0jXGL18wjKLcJAryNzkfpl81koyVYeXPG7gxxe5wCZcIMos3K30B
        XTpi6Qc4NPizTsnbckmHUn+/JmV8kGpPLWPWcf0EqvsS6HNQXoq17O6npChc5Wui
        YKYcz0MmozqQGWZIwKI8GO4n/57Shc=
Received: by ajax-webmail-email1 (Coremail) ; Sat, 8 Jul 2023 10:47:21 +0800
 (GMT+08:00)
X-Originating-IP: [10.201.164.53]
Date:   Sat, 8 Jul 2023 10:47:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5ZGo6YC45p6X?= <ylzhou@whu.edu.cn>
To:     stable@vger.kernel.org
Subject: A linux kernel bug report about a USBcore driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2023 www.mailtech.cn whu
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f7137bb.c0125.18933658fac.Coremail.ylzhou@whu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQBjCgDHiLw5zqhkOM+ZCg--.4383W
X-CM-SenderInfo: qsqrljiqrviiqqqrq4lkxovvfxof0/1tbiAQUEElmj4e7QfQABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear developer, I am a security researcher at Wuhan University. Recently I discovered a vulnerability in the driver of the USBcore module in the Linux kernel. This vulnerability will lead to an infinite loop in the probe process of the USB device, which will consume a lot of system resources. The vulnerability was found in kernel version 5.6.19 and tested to exist in the new 6.3.7 kernel version as well. I hope that after your review, you will be able to apply for a CVE number to disclose this vulnerability. If you need more detailed vulnerability information, please   contact me. Thank you for your help.
