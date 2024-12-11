Return-Path: <stable+bounces-100660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD79ED1E9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F9018836A1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E41DDA3C;
	Wed, 11 Dec 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9lDIb6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB341DD9A6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934763; cv=none; b=Uflu0ycfqme+ljzBolq0q6MXbEzDKTmIp+7mi4LyxVuJi53a9rguJwXY+04Zi5C1gLzJj+pSCYIEaxRJzQ3xWSrWeqhDPIDDfXMv+5km3mbDwTlCh6LYAzxlEKFyerHgUVYvooYzbrU6JGVw/p371LsjKACA5SElJV2M3gZAPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934763; c=relaxed/simple;
	bh=J/ivDVC7kVNRDhG3LH2PPB2iNdC289IUqZQQaAbZlkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj9VnBi4R5xmn9kUIJpIufhaBPHaZk+q9eCAPY/wSb+58e0FJ//Kan3dAEzNhxED8/xonameVJznEp7zjeHJ0fTN9kwga226qw8r22X4zcmGxkCITAK4psnWqVk3b382PFgTqOuqoqJSpERNdLi9AuWTTKGvmmq5CwD4m0oJflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9lDIb6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7439C4CED2;
	Wed, 11 Dec 2024 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934763;
	bh=J/ivDVC7kVNRDhG3LH2PPB2iNdC289IUqZQQaAbZlkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9lDIb6Y4wrXXr5oyJFCDT3VfC4C0jJnnrXNRUdo7mjWIFUJIgjtGK9Ko7AZmXWYR
	 6cJt9Lukfwawp3iR4mxzZiD0IfGgRwZbZQPzm/lBaD1qLtkDn6oYu9wmWqmf9i05kQ
	 5xUYtw90NKXdDC8l2G4r1N3ov5XrSnpzhJEclU/gavi2SXdj1mGgpLWHKqC6JxlThf
	 2va5CzdSozxRmB4knC8fgAvrkkken+D+YGrKEgkvX67imzBd5+xrLsPYqvQpqkoBiK
	 /Q2UfNzmm0HQgP9GFyu0fBL8v0AD4V9WMm1wpPvrg1/353CffHFUGRFsCH2fKo8E+d
	 d6kYUheoL136g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel][5.15.y][PATCH 1/5] serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Date: Wed, 11 Dec 2024 11:32:41 -0500
Message-ID: <20241211105523-563c497486a8e21e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211042545.202482-2-hui.wang@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 3837a0379533aabb9e4483677077479f7c6aa910

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hui Wang <hui.wang@canonical.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 452ed2b218b1)
6.1.y | Present (different SHA1: 45ec1b7accd5)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3837a0379533a ! 1:  cffffd769d922 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
    @@ Metadata
      ## Commit message ##
         serial: sc16is7xx: improve regmap debugfs by using one regmap per port
     
    +    commit 3837a0379533aabb9e4483677077479f7c6aa910 upstream.
    +
         With this current driver regmap implementation, it is hard to make sense
         of the register addresses displayed using the regmap debugfs interface,
         because they do not correspond to the actual register addresses documented
    @@ Commit message
         As an added bonus, this also simplifies some operations (read/write/modify)
         because it is no longer necessary to manually shift register addresses.
     
    +    [Hui: Fixed some conflict when backporting to 5.15.y]
    +
         Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
         Link: https://lore.kernel.org/r/20231030211447.974779-1-hugo@hugovil.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Hui Wang <hui.wang@canonical.com>
     
      ## drivers/tty/serial/sc16is7xx.c ##
     @@
    - 
    + 						  */
      
      /* Misc definitions */
     +#define SC16IS7XX_SPI_READ_BIT		BIT(7)
      #define SC16IS7XX_FIFO_SIZE		(64)
     -#define SC16IS7XX_REG_SHIFT		2
    - #define SC16IS7XX_GPIOS_PER_BANK	4
    ++#define SC16IS7XX_GPIOS_PER_BANK	4
      
      struct sc16is7xx_devtype {
    + 	char	name[10];
     @@ drivers/tty/serial/sc16is7xx.c: struct sc16is7xx_one_config {
      struct sc16is7xx_one {
      	struct uart_port		port;
    @@ drivers/tty/serial/sc16is7xx.c: struct sc16is7xx_one_config {
     +	struct regmap			*regmap;
      	struct kthread_work		tx_work;
      	struct kthread_work		reg_work;
    - 	struct kthread_delayed_work	ms_work;
    -@@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_stop_tx(struct uart_port *port);
    - 
    + 	struct sc16is7xx_one_config	config;
    +@@ drivers/tty/serial/sc16is7xx.c: static struct uart_driver sc16is7xx_uart = {
    + #define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
      #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
      
     -static int sc16is7xx_line(struct uart_port *port)
    @@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_stop_tx(struct uart_port *
     -	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
     +	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
      
    --	regcache_cache_bypass(s->regmap, true);
    --	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
    --	regcache_cache_bypass(s->regmap, false);
    -+	regcache_cache_bypass(one->regmap, true);
    -+	regmap_raw_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
    -+	regcache_cache_bypass(one->regmap, false);
    +-	regmap_noinc_read(s->regmap, addr, s->buf, rxlen);
    ++	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
      }
      
      static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
    @@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_fifo_write(struct uart_por
      	if (unlikely(!to_send))
      		return;
      
    --	regcache_cache_bypass(s->regmap, true);
    --	regmap_raw_write(s->regmap, addr, s->buf, to_send);
    --	regcache_cache_bypass(s->regmap, false);
    -+	regcache_cache_bypass(one->regmap, true);
    -+	regmap_raw_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
    -+	regcache_cache_bypass(one->regmap, false);
    +-	regmap_noinc_write(s->regmap, addr, s->buf, to_send);
    ++	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
      }
      
      static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
    @@ drivers/tty/serial/sc16is7xx.c: static bool sc16is7xx_regmap_volatile(struct dev
      	case SC16IS7XX_RHR_REG:
      		return true;
      	default:
    -@@ drivers/tty/serial/sc16is7xx.c: static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
    +@@ drivers/tty/serial/sc16is7xx.c: static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
      static int sc16is7xx_set_baud(struct uart_port *port, int baud)
      {
      	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
     +	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
      	u8 lcr;
    - 	u8 prescaler = 0;
    + 	unsigned int prescaler = 1;
      	unsigned long clk = port->uartclk, div = clk / 16 / baud;
     @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_set_baud(struct uart_port *port, int baud)
      			     SC16IS7XX_LCR_CONF_MODE_B);
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_set_baud(struct uart_port *
      	/* Enable enhanced features */
     -	regcache_cache_bypass(s->regmap, true);
     +	regcache_cache_bypass(one->regmap, true);
    - 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
    - 			      SC16IS7XX_EFR_ENABLE_BIT,
    - 			      SC16IS7XX_EFR_ENABLE_BIT);
    - 
    + 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
    + 			     SC16IS7XX_EFR_ENABLE_BIT);
     -	regcache_cache_bypass(s->regmap, false);
     +	regcache_cache_bypass(one->regmap, false);
      
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_set_baud(struct uart_port *
      
      	/* Put LCR back to the normal mode */
      	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
    +@@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_set_termios(struct uart_port *port,
    + 				  struct ktermios *old)
    + {
    + 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
    ++	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
    + 	unsigned int lcr, flow = 0;
    + 	int baud;
    + 
     @@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_set_termios(struct uart_port *port,
      			     SC16IS7XX_LCR_CONF_MODE_B);
      
    @@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_set_termios(struct uart_po
     +	regcache_cache_bypass(one->regmap, true);
      	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
      	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
    - 
    + 	if (termios->c_cflag & CRTSCTS)
     @@ drivers/tty/serial/sc16is7xx.c: static void sc16is7xx_set_termios(struct uart_port *port,
    - 			      SC16IS7XX_EFR_REG,
    - 			      SC16IS7XX_EFR_FLOWCTRL_BITS,
    - 			      flow);
    + 		flow |= SC16IS7XX_EFR_SWFLOW1_BIT;
    + 
    + 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG, flow);
     -	regcache_cache_bypass(s->regmap, false);
     +	regcache_cache_bypass(one->regmap, false);
      
      	/* Update LCR register */
      	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
    -@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
    +@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_config_rs485(struct uart_port *port,
      static int sc16is7xx_startup(struct uart_port *port)
      {
      	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
     -	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
      	unsigned int val;
    - 	unsigned long flags;
      
    + 	sc16is7xx_power(port, 1);
     @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_startup(struct uart_port *port)
      	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
      			     SC16IS7XX_LCR_CONF_MODE_B);
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_startup(struct uart_port *p
     +	regcache_cache_bypass(one->regmap, true);
      
      	/* Enable write access to enhanced features and internal clock div */
    - 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
    + 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
     @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_startup(struct uart_port *port)
      			     SC16IS7XX_TCR_RX_RESUME(24) |
      			     SC16IS7XX_TCR_RX_HALT(48));
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_startup(struct uart_port *p
      
      	/* Now, initialize the UART */
      	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
    -@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
    - 	if (s->mctrl_mask)
    - 		regmap_update_bits(
    - 			s->regmap,
    --			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
    -+			SC16IS7XX_IOCONTROL_REG,
    - 			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
    - 			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
    - 
    -@@ drivers/tty/serial/sc16is7xx.c: static const struct serial_rs485 sc16is7xx_rs485_supported = {
    +@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
      
      static int sc16is7xx_probe(struct device *dev,
      			   const struct sc16is7xx_devtype *devtype,
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_probe(struct device *dev,
      	for (i = 0; i < devtype->nr_uart; ++i) {
      		s->p[i].line		= i;
     @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_probe(struct device *dev,
    + 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
      		s->p[i].port.ops	= &sc16is7xx_ops;
    - 		s->p[i].old_mctrl	= 0;
      		s->p[i].port.line	= sc16is7xx_alloc_line();
     +		s->p[i].regmap		= regmaps[i];
    - 
    ++
      		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
      			ret = -ENOMEM;
    + 			goto out_ports;
     @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_probe(struct device *dev,
      		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
      				     SC16IS7XX_LCR_CONF_MODE_B);
    @@ drivers/tty/serial/sc16is7xx.c: static const struct of_device_id __maybe_unused
      	.cache_type = REGCACHE_RBTREE,
      	.volatile_reg = sc16is7xx_regmap_volatile,
      	.precious_reg = sc16is7xx_regmap_precious,
    + 	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
    + 	.readable_noinc_reg = sc16is7xx_regmap_noinc,
     +	.max_register = SC16IS7XX_EFCR_REG,
      };
      
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_spi_probe(struct spi_device
     +	return sc16is7xx_probe(&spi->dev, devtype, regmaps, spi->irq);
      }
      
    - static void sc16is7xx_spi_remove(struct spi_device *spi)
    -@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
    + static int sc16is7xx_spi_remove(struct spi_device *spi)
    +@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
    + 			       const struct i2c_device_id *id)
      {
    - 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
      	const struct sc16is7xx_devtype *devtype;
     -	struct regmap *regmap;
     +	struct regmap *regmaps[2];
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client
      
      	if (i2c->dev.of_node) {
      		devtype = device_get_match_data(&i2c->dev);
    -@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
    +@@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
      		devtype = (struct sc16is7xx_devtype *)id->driver_data;
      	}
      
    @@ drivers/tty/serial/sc16is7xx.c: static int sc16is7xx_i2c_probe(struct i2c_client
     +	return sc16is7xx_probe(&i2c->dev, devtype, regmaps, i2c->irq);
      }
      
    - static void sc16is7xx_i2c_remove(struct i2c_client *client)
    + static int sc16is7xx_i2c_remove(struct i2c_client *client)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

