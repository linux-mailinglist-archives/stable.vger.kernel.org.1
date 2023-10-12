Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF57C7330
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjJLQjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJLQjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 12:39:16 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B0A9
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 09:39:15 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 33E68865A5;
        Thu, 12 Oct 2023 18:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1697128752;
        bh=ZJd4K88CnuvOXjD1PtHw6ogrxdLHEDGMAdtt00r/2zA=;
        h=Date:To:Cc:From:Subject:From;
        b=M5G+uZoMiOZaqJ2g1mJmspNnthYTgz102MxEBthx9y7aq2iovDSsPlpqxxyVsFyXA
         gParIx6SQyWV+oZ2gbD7C0Zv3VBCL902OjmgpVZ8o6ZfCnCarps71/uE17KUFzGKbb
         ykRg186zul+7++hhXWRsL9XrS0VMNQrpG6HBIQBi+USNePwz8+EH86UuY06I0AjWv6
         O4rm1wjfF9pr/r6Fqc/pwBAGS/CLAnBLZJpBfIzdSTtDI8VN0wV1I8W8fAbh9/FtXd
         zU+ETUYIICW2lmzNjrOS48H25gd2NnWpEA9RI49IhuP8y53cCCFgYQZDr0pUZSfRVx
         FNMZzQhUQizzg==
Message-ID: <9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de>
Date:   Thu, 12 Oct 2023 18:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-stable <stable@vger.kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
From:   Marek Vasut <marex@denx.de>
Subject: Possibly broken Linux 5.10.198 backport spi: spi-zynqmp-gqspi: Fix
 runtime PM imbalance in zynqmp_qspi_probe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Linux 5.10.198 commit
2cdec9c13f81 ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in 
zynqmp_qspi_probe")

looks very different compared to matching upstream commit:
a21fbc42807b ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in 
zynqmp_qspi_probe")

The Linux 5.10.198 change breaks a platform for me and it really looks 
like an incorrect backport.

Dinghao, can you have a look ?

Thank you
