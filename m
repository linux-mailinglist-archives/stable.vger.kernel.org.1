Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43D73CA62
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjFXKGn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFXKGm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 06:06:42 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000A211E
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boaniger.com;
        s=selector3; t=1687601198; i=@boaniger.com;
        bh=Wuj+h4mwV9Tm7duhBINktIbLhIzOXSNpyo9CJUmQGJM=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Reply-To:Message-ID;
        b=SUH8NWi6GjC9yohDt0pJLY27A23h20D3m+Jkpcwa/Linh7AvFqbpl8lJ0se8cBuld
         ghCdSIBScTFaicsMA9i5VVmFcH5IijDipcldxamir8eZdZx0FgkV3PzJxcLz/VCz/P
         bwbyscVSyIk1JLJ4KYb2QSqFo+RlgLELjBitKsD4=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRWlGSWpSXmKPExsUyy+mus67mgWk
  pBu0XRCx+z+hksbi08RKrxcmLf5kstix/wGix78JjdosFGx8xWtxfe4PN4tT8LYwWs7/sZLa4
  OfUls8WPT6fZLc7OX8xssezBXUaLXauELObcamG3+H7lIqvFn0m1Fu+2zWayeHL6AptF/55rL
  A4iHjcvNjF63N+9kt3j29+prB5Ttp0DsnY/ZPS4fHEGq0fXvOMsHkdaNjN5tL+bxuwx8fg/No
  +ds+6ye8zbconRY9LdWYwex9b+Y/bof9vG7jHh1n7mAJEo1sy8pPyKBNaMH+3tTAXJFV9//WR
  pYAzoYuTiEBL4xihxoeMMO5xz6/NxKOcgo0Rbz3XGLkZODmYBPYkbU6ewgdi8AoISJ2c+YYGI
  a0ssW/iauYuRA8hWk/jaVQISFhbglvjyaj1Yq4iAssSLa3uYQGw2IPvz45fMIDaLgKpE9/Wj7
  CC2kICcxLIH85khxvtLtF27xwoRl5f4dvMh8wRGvllIrpiF5IpZSK6YhXDFAkaWVYxmxalFZa
  lFuoYGeklFmekZJbmJmTl6iVW6iXqppbrlqcUluoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiB8Z5
  SzPBwB+PUnn96hxglOZiURHlTTKakCPEl5adUZiQWZ8QXleakFh9i1OPgELhw9uEnRoErHz41
  MUmx5OXnpSpJ8B7fMy1FSLAoNT21Ii0zB5ieYBokOHiURHj/7wZK8xYXJOYWZ6ZDpE4xxnJsX
  rh3LzPHsUUgcvXO/UByO5h833QRSH76eAVIPjhwDSR+AUR+3dZ1gFmIJb0osVJKnDcQZKcAyN
  CM0jy4lbBUfIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK/mfqApPJl5JXCXvQI6mgno6HS
  tySBHlyQipKQamJi5Nk1LDPdhufR74+GL9Xdm2/oc7WfIdDsacftk5ulDkbr8il3ii1SfHLt2
  YqO8zwGJyXOOdWUreTU5L9v841qT+sHJfJdvHDZTS5f32LZEfGpE/E7eNd/39zFairNk7T3Ml
  nPv6TFvxSbfVy+d+HgVXhW261puiXwg7T2/z1S6KdZ10TnWPy9tPx+sWKuXepulPnwOjxLTM4
  7i4DqxYxwsT5+sPew1984Nvta1vfGfFqsf7m9wVZ34PUddbpp5DNOX6/WL5H/xbwpwDLu7xSK
  OvfnY4Vksqh1J7tIR4YE3OYNz++8u/RE688PSItkzoW3HniZcKfZZfFVYN2mmeX3PxsyPTpPE
  Ih+uOmIrr8RSnJFoqMVcVJwIACuIvzVABAAA
X-Env-Sender: olena@boaniger.com
X-Msg-Ref: server-2.tower-564.messagelabs.com!1687601184!65190!9
X-Originating-IP: [154.66.221.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5894 invoked from network); 24 Jun 2023 10:06:33 -0000
Received: from unknown (HELO mail.boaniger.com) (154.66.221.67)
  by server-2.tower-564.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Jun 2023 10:06:33 -0000
Received: from WINSRVNE-ARCH.boaniger.local (10.107.72.27) by
 WINSRVNE-EXCH.boaniger.local (10.107.72.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Jun 2023 11:06:30 +0100
Received: from WINSRVNE-EXCH.boaniger.local (10.107.72.8) by
 WINSRVNE-ARCH.boaniger.local (10.107.72.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Jun 2023 11:06:29 +0100
Received: from [85.217.144.32] (85.217.144.32) by WINSRVNE-EXCH.boaniger.local
 (10.107.72.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sat, 24 Jun 2023 11:06:25 +0100
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi
To:     Recipients <olena@boaniger.com>
From:   Ms Olena <olena@boaniger.com>
Date:   Sat, 24 Jun 2023 12:05:01 +0200
Reply-To: <os904425@gmail.com>
Message-ID: <cfa8736e-3089-4712-8fdd-8068941822aa@WINSRVNE-EXCH.boaniger.local>
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: boaniger.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [195.245.230.2 listed in list.dnswl.org]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?85.217.144.32>]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [85.217.144.32 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [195.245.230.2 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [os904425[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,
I have funds for investment. Can we partner if you have a good business ide=
a?
Thanks, Olena.
