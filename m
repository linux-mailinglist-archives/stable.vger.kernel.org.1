Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828AB6F3DE9
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBGzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 02:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjEBGzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 02:55:07 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D249F2
        for <stable@vger.kernel.org>; Mon,  1 May 2023 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1683010501; x=1714546501;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ja+JOU/7heFYoS/+eOxCjX6HTqTjKKxenwFLCMVLk9o=;
  b=PBQNpnn0XHgKrV4y2lgS8QimK/b5jFgfewE4ZRmbLMN+eWoBaKBbSmjl
   ztEhH65IwLy0WUnp4H2C8TPt1OA/RkyN4mgESeoC0+GUkHg/763prNEBx
   7Qy+Ecj7DsQT5Ehd2hyZ9u56Yf9befJxcjfyaCEbB/tfB7vzistMqSFL8
   c=;
X-IronPort-AV: E=Sophos;i="5.99,243,1677542400"; 
   d="scan'208";a="327057805"
Subject: Re: [PATCH 5.10 0/1] Request to cherry-pick 026d0d27c488 to 5.10.y
Thread-Topic: [PATCH 5.10 0/1] Request to cherry-pick 026d0d27c488 to 5.10.y
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 06:54:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 8BA79817F5;
        Tue,  2 May 2023 06:54:58 +0000 (UTC)
Received: from EX19D023UWA002.ant.amazon.com (10.13.139.65) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 2 May 2023 06:54:58 +0000
Received: from EX19D023UWA003.ant.amazon.com (10.13.139.33) by
 EX19D023UWA002.ant.amazon.com (10.13.139.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 May 2023 06:54:58 +0000
Received: from EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de]) by
 EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de%6]) with mapi id
 15.02.1118.026; Tue, 2 May 2023 06:54:57 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Meena Shanmugam <meenashanmugam@google.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Thread-Index: AQHZfLardOFdg0PchU69+akxnSROqa9GFzYA
Date:   Tue, 2 May 2023 06:54:57 +0000
Message-ID: <450069D4-6F18-4C51-B9E4-EBB8F1C8A5BA@amazon.com>
References: <20230502052554.3068013-1-meenashanmugam@google.com>
In-Reply-To: <20230502052554.3068013-1-meenashanmugam@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.94.223.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <21408E3E028D2F42B263D99BC8E505C3@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

TWVlbmEsIA0KDQpUaGlzIHBhdGNoIGltcGxpY2l0bHkgcmVsaWVzIG9uIGNvcnJlY3RuZXNzIG9m
IHRoZSBvdmVyaGVhZCBmaWVsZCBpbiB0aGUgc3VwZXJibG9jay4gIEluIHRoZSBvbGRlciBrZXJu
ZWxzLCBvbmxpbmUgcmVzaXplIG5lZ2xlY3RlZCB0byB1cGRhdGUgdGhlIG92ZXJoZWFkIGZpZWxk
LiAgVGVkIChvciBMdWNhcz8pIGZpeGVkIHRoYXQsIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhhdCBw
YXRjaCBnb3QgY2hlcnJ5LXBpY2tlZCBmb3IgdGhlIG9sZGVyIHN0YWJsZSByZWxlYXNlcy4gIEkg
ZG9uJ3QgdGhpbmsgbXkgcGF0Y2ggd2lsbCB3b3JrIHJpZ2h0IHdpdGhvdXQgdGhvc2UgZml4ZXMu
DQoNCu+7v09uIDUvMS8yMywgMTA6MjYgUE0sICJNZWVuYSBTaGFubXVnYW0iIDxtZWVuYXNoYW5t
dWdhbUBnb29nbGUuY29tIDxtYWlsdG86bWVlbmFzaGFubXVnYW1AZ29vZ2xlLmNvbT4+IHdyb3Rl
Og0KDQoNCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhl
IG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQoNCg0KDQoNCg0KDQpUaGUgY29tbWl0IDAyNmQwZDI3YzQ4OCAoZXh0NDogcmVkdWNlIGNv
bXB1dGF0aW9uIG9mIG92ZXJoZWFkIGR1cmluZw0KcmVzaXplKSByZWR1Y2VzIHRoZSB0aW1lIHRh
a2VuIHRvIHJlc2l6ZSBsYXJnZSBiaWdhbGxvYw0KZmlsZXN5c3RlbXMocmVkdWNlcyAzKyBob3Vy
cyB0byBtaWxsaXNlY29uZHMgZm9yIGEgNjRUQiBGUykuIFRoaXMgaXMgYQ0KZ29vZCBjYW5kaWRh
dGUgdG8gY2hlcnJ5LXBpY2sgdG8gc3RhYmxlIHJlbGVhc2VzLg0KDQoNCktpc2VsZXYsIE9sZWcg
KDEpOg0KZXh0NDogcmVkdWNlIGNvbXB1dGF0aW9uIG9mIG92ZXJoZWFkIGR1cmluZyByZXNpemUN
Cg0KDQpmcy9leHQ0L3Jlc2l6ZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCjEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQoNCi0tDQoyLjQw
LjEuNDk1LmdjODE2ZTA5YjUzZC1nb29nDQoNCg0KDQoNCg0K
