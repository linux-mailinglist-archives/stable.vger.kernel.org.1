Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6A7511F0
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGLUlP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGLUlL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 16:41:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17511FE4
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 13:41:09 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 23ED621C44E9;
        Wed, 12 Jul 2023 13:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23ED621C44E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689194469;
        bh=Az1l4FGS9DpEUynuPADZgkp8C26naorOwGWX3rHot6E=;
        h=From:Subject:References:To:Date:From;
        b=r3ZQGZ5rbnV5o+6vl1d6/wwpX0p467ikTl+SHOqt7BSFL7Ljd2cdi6uFrtmcW+mCX
         M6L9CUqO785mcqIfuhSJTyvUFsKYQgcxpJpiD0TmWKjJ3ewhSftIYqh9I50nYkPqy6
         mn7nCneaiTYdMGFIqxrnV/IrLfBxIpRNplVJsTWc=
From:   Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Backport Request: ipvs: increase ip_vs_conn_tab_bits range for 64BIT
Message-Id: <D1B92E6E-A6AD-4D7E-B806-8D7029CDEE68@linux.microsoft.com>
References: <53777E0A-89E0-4326-8B43-6F023E6B0D65@linux.microsoft.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 12 Jul 2023 13:40:58 -0700
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

 Could you please pick the below commit for v6.3, v6.1 and v5.15

Upstream Commit:
04292c695f82 2023-05-16ipvs: increase ip_vs_conn_tab_bits range for =
64BIT [Pablo Neira Ayuso]

Thanks,
Allen=
